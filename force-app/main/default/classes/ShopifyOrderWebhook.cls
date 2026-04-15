@RestResource(urlMapping='/shopify/*')
global without sharing class ShopifyOrderWebhook {

    @HttpPost
    global static void dispatch() {
        final RestRequest  req = RestContext.request;
        final RestResponse res = RestContext.response;

        String topic   = req.headers.get('X-Shopify-Topic');
        String hmacHdr = req.headers.get('X-Shopify-Hmac-Sha256');
        Blob   body    = req.requestBody;
        String bodyStr = (body == null) ? null : body.toString();

        log('Incoming topic: ' + topic);
        System.debug(LoggingLevel.WARN, '[Shopify] Raw JSON: ' + bodyStr);

        if (!verifyShopifyHmac(hmacHdr, body)) {
            res.statusCode  = 401;
            res.responseBody = Blob.valueOf('Invalid HMAC');
            return;
        }

        Map<String, Object> root;
        try { root = (Map<String, Object>) JSON.deserializeUntyped(bodyStr); }
        catch (Exception e) {
            res.statusCode  = 400;
            res.responseBody = Blob.valueOf('Invalid JSON');
            log('Invalid JSON: ' + e.getMessage());
            return;
        }

        String t = (topic == null) ? '' : topic.toLowerCase();

        if (t == 'orders/create' || t == 'orders/paid' || t == 'orders/updated' || t == 'orders/fulfilled') {
            handleOrderToOpportunity(root);
            return;
        }

        if (t == 'orders/cancelled' || t == 'orders/canceled') {
            handleOrderToOpportunity(root);
            return;
        }

        if (t == 'orders/delete' || t == 'orders/removed') {
            handleOrderDelete(root);
            return;
        }

        if (t == 'customers_email_marketing_consent/update') {
            handleEmailMarketingConsent(root);
            return;
        }

        if (t == 'customers/create' || t == 'customers/update') {
            handleCustomerToContact(root);
            return;
        }
        if (t == 'refunds/create' || t == 'refunds/update') {
            handleRefund(root);
            return;
        }

        log('Topic not handled: ' + topic + ' (ack 200)');
        res.statusCode  = 200;
        res.responseBody = Blob.valueOf('ignored');
    }

    // ------------------- Config / RecordType lookup -------------------

    private static final String OPP_RT_DEVNAME = 'Merchandise';
    private static Id OPP_RT_ID;

    private static Id getMerchOppRecordTypeId() {
        if (OPP_RT_ID == null) {
            List<RecordType> rts = [
                SELECT Id FROM RecordType
                WHERE SObjectType = 'Opportunity'
                AND (DeveloperName = :OPP_RT_DEVNAME OR Name = :OPP_RT_DEVNAME)
                LIMIT 1
            ];
            OPP_RT_ID = (rts.isEmpty()) ? null : rts[0].Id;
        }
        return OPP_RT_ID;
    }

    // ------------------- Orders → Contact + Opportunity + Product2 -------------------

    private static void handleOrderToOpportunity(Map<String, Object> root) {
        final RestResponse res = RestContext.response;
        try {
            Id contactId = upsertContactFromOrderPayload(root);

            Opportunity opp = mapOrderToOpportunity(root, contactId);
            upsert opp Shopify_Order_Id__c;

            log('Upserted Opportunity Id=' + opp.Id);

            List<Product2> prodRows = mapLineItemsToProducts(root, opp.Id);
            if (!prodRows.isEmpty()) upsert prodRows Shopify_Order_Line_Item_Id__c;

            res.statusCode  = 200;
            res.responseBody = Blob.valueOf('ok');
        } catch (Exception e) {
            log('ERROR in handleOrderToOpportunity: ' + e.getMessage());
            res.statusCode  = 500;
            res.responseBody = Blob.valueOf('Opportunity upsert failed: ' + e.getMessage());
        }
    }

    private static void handleOrderDelete(Map<String, Object> root) {
        final RestResponse res = RestContext.response;
        try {
            String orderIdStr = s(root.get('id'));
            if (String.isBlank(orderIdStr)) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('missing id');
                return;
            }

            List<Opportunity> opps = [
                SELECT Id FROM Opportunity WHERE Shopify_Order_Id__c = :orderIdStr LIMIT 1
            ];
            if (opps.isEmpty()) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('not found');
                return;
            }

            Opportunity opp = opps[0];
            List<Product2> children = [SELECT Id FROM Product2 WHERE Opportunity__c = :opp.Id];

            if (!children.isEmpty()) delete children;
            delete opp;

            res.statusCode  = 200;
            res.responseBody = Blob.valueOf('deleted');
        } catch (Exception e) {
            log('ERROR deleting order: ' + e.getMessage());
            res.statusCode  = 500;
            res.responseBody = Blob.valueOf('delete failed');
        }
    }

    private static Opportunity mapOrderToOpportunity(Map<String, Object> root, Id contactId) {
        Opportunity o = new Opportunity();
        o.Shopify_Order_Id__c = s(root.get('id'));
        o.RecordTypeId = getMerchOppRecordTypeId();
        o.Name = s(root.get('name'));
        if (String.isBlank(o.Name)) o.Name = 'Shopify Order ' + s(root.get('id'));

        o.Amount = d(root.get('total_price'));
        o.StageName = 'Closed Won';
        o.CloseDate = Date.today();
        o.Fund_Designation__c = 'POW';
        if (contactId != null) o.npsp__Primary_Contact__c = contactId;

        Datetime cancelledAt = dt(root.get('cancelled_at'));
        String cancelReason  = s(root.get('cancel_reason'));
        if (cancelledAt != null) {
            o.Cancelled__c = true;
            o.Cancelled_At__c = cancelledAt;
            o.Cancel_Reason__c = cancelReason;
            o.StageName = 'Closed Lost';
        } else {
            o.Cancelled__c = false;
            o.Cancelled_At__c = null;
        }
        return o;
    }

    private static List<Product2> mapLineItemsToProducts(Map<String, Object> root, Id oppId) {
        List<Product2> out = new List<Product2>();
        List<Object> items = (List<Object>) root.get('line_items');
        if (items == null) return out;

        for (Object obj : items) {
            Map<String, Object> li = (Map<String, Object>) obj;
            Product2 p = new Product2();
            p.Shopify_Order_Line_Item_Id__c = s(li.get('id'));
            p.Name = s(li.get('title'));
            p.ProductCode = s(li.get('sku'));
            p.IsActive = true;
            p.Opportunity__c = oppId;
            out.add(p);
        }
        return out;
    }

    // ------------------- Customer → Contact -------------------

    private static void handleCustomerToContact(Map<String, Object> root) {
        final RestResponse res = RestContext.response;
        try {
            Id cid = upsertContactFromCustomerPayload(root);
            if (cid != null) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('ok');
            } else {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('skipped');
            }
        } catch (Exception e) {
            log('ERROR in handleCustomerToContact: ' + e.getMessage());
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('contact upsert failed');
        }
    }

    private static Id upsertContactFromOrderPayload(Map<String, Object> root) {
        Map<String, Object> cust = (Map<String, Object>) root.get('customer');
        String email = s(root.get('contact_email'));
        if (String.isBlank(email) && cust != null) email = s(cust.get('email'));
        if (String.isBlank(email)) email = s(root.get('email'));

        String first = (cust != null) ? s(cust.get('first_name')) : null;
        String last  = (cust != null) ? s(cust.get('last_name')) : null;
        Map<String, Object> addr = (cust != null) ? (Map<String, Object>) cust.get('default_address') : null;

        return upsertContact(email, first, last, null, addr);
    }

    private static Id upsertContactFromCustomerPayload(Map<String, Object> root) {
        String email = s(root.get('email'));
        if (String.isBlank(email)) return null;
        return upsertContact(email, s(root.get('first_name')), s(root.get('last_name')), s(root.get('phone')), (Map<String, Object>) root.get('default_address'));
    }

    private static Id upsertContact(String email, String first, String last, String phone, Map<String, Object> addr) {
        if (String.isBlank(email)) return null;

        Contact rec;
        List<Contact> existing = [SELECT Id FROM Contact WHERE Email = :email LIMIT 1];
        rec = existing.isEmpty() ? new Contact() : new Contact(Id = existing[0].Id);

        rec.FirstName = first;
        rec.LastName  = String.isBlank(last) ? 'Shopify Customer' : last;
        rec.Email     = email;
        rec.Phone     = phone;

        if (addr != null) {
            rec.MailingStreet     = s(addr.get('address1'));
            rec.MailingCity       = s(addr.get('city'));
            rec.MailingPostalCode = s(addr.get('zip'));
            rec.MailingCountryCode = s(addr.get('country_code'));
            rec.MailingStateCode   = s(addr.get('province_code'));
            if (String.isBlank(rec.MailingCountryCode))
                rec.MailingCountry = s(addr.get('country_name'));
            if (String.isBlank(rec.MailingStateCode))
                rec.MailingState = s(addr.get('province'));
        }

        if (rec.Id == null) insert rec; else update rec;
        return rec.Id;
    }

    // ------------------- Email Marketing Consent -------------------

    private static void handleEmailMarketingConsent(Map<String, Object> root) {
        final RestResponse res = RestContext.response;
        try {
            String email = s(root.get('email_address'));
            Map<String, Object> consent = (Map<String, Object>) root.get('email_marketing_consent');
            String state = (consent == null) ? null : s(consent.get('state'));

            if (String.isBlank(email) || String.isBlank(state)) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('missing data');
                return;
            }

            Boolean optOut = (state == 'subscribed') ? false : true;

            List<Contact> cons = [SELECT Id FROM Contact WHERE Email = :email];
            if (cons.isEmpty()) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('contact not found');
                return;
            }

            for (Contact c : cons) c.HasOptedOutOfEmail = optOut;
            update cons;

            res.statusCode = 200;
            res.responseBody = Blob.valueOf('ok');
        } catch (Exception e) {
            log('ERROR in handleEmailMarketingConsent: ' + e.getMessage());
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('consent update failed');
        }
    }
    
    private static void handleRefund(Map<String, Object> root) {
        final RestResponse res = RestContext.response;
        try {
            String orderId = s(root.get('order_id'));
            if (String.isBlank(orderId)) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('missing order_id');
                return;
            }
    
            // Find related Opportunity
            List<Opportunity> oppList = [
                SELECT Id, Name FROM Opportunity WHERE Shopify_Order_Id__c = :orderId LIMIT 1
            ];
            if (oppList.isEmpty()) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('no related opportunity');
                return;
            }
    
            Opportunity opp = oppList[0];
    
            // Find related Payment
            List<npe01__OppPayment__c> payments = [
                SELECT Id, Refund_Amount__c, Refunded_Items__c
                FROM npe01__OppPayment__c
                WHERE npe01__Opportunity__c = :opp.Id
                LIMIT 1
            ];
            if (payments.isEmpty()) {
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('no related payment');
                return;
            }
    
            npe01__OppPayment__c payment = payments[0];
    
            // Calculate refund from current payload
            Decimal refundFromPayload = 0;
            if (root.containsKey('transactions')) {
                List<Object> txns = (List<Object>) root.get('transactions');
                for (Object tObj : txns) {
                    Map<String, Object> txn = (Map<String, Object>) tObj;
                    if (s(txn.get('kind')) == 'refund') {
                        Decimal amt = d(txn.get('amount'));
                        if (amt != null) refundFromPayload += amt;
                    }
                }
            }
    
            // Combine with existing refund total
            Decimal existingRefund = (payment.Refund_Amount__c == null) ? 0 : payment.Refund_Amount__c;
            Decimal newRefundTotal = existingRefund + refundFromPayload;
    
            // Collect refunded items (append to existing if any)
            String refundedSummary = payment.Refunded_Items__c == null ? '' : payment.Refunded_Items__c;
            List<String> refundedSkus = new List<String>();
    
            if (root.containsKey('refund_line_items')) {
                List<Object> items = (List<Object>) root.get('refund_line_items');
                List<String> descs = new List<String>();
                for (Object i : items) {
                    Map<String, Object> li = (Map<String, Object>) i;
                    Map<String, Object> lineItem = (Map<String, Object>) li.get('line_item');
                    if (lineItem != null) {
                        String title = s(lineItem.get('title'));
                        String sku = s(lineItem.get('sku'));
                        if (!String.isBlank(title)) {
                            descs.add(title + (String.isNotBlank(sku) ? ' (' + sku + ')' : ''));
                        }
                        if (!String.isBlank(sku)) refundedSkus.add(sku);
                    }
                }
                if (!descs.isEmpty()) {
                    if (String.isNotBlank(refundedSummary)) refundedSummary += ', ';
                    refundedSummary += String.join(descs, ', ');
                }
            }
    
            // Update Payment record
            payment.Refund_Amount__c = newRefundTotal;
            payment.Refunded_Items__c = refundedSummary;
            update payment;
    
            // Update Product2.Refunded__c for relevant SKUs
            if (!refundedSkus.isEmpty()) {
                List<Product2> productsToUpdate = [
                    SELECT Id, ProductCode, Refunded__c
                    FROM Product2
                    WHERE Opportunity__c = :opp.Id
                    AND ProductCode IN :refundedSkus
                ];
    
                for (Product2 p : productsToUpdate) {
                    p.Refunded__c = true;
                }
    
                if (!productsToUpdate.isEmpty()) update productsToUpdate;
            }
    
            res.statusCode = 200;
            res.responseBody = Blob.valueOf('refund added successfully');
        } catch (Exception e) {
            log('ERROR in handleRefund: ' + e.getMessage());
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('refund failed');
        }
    }

    // ------------------- Helpers -------------------

    private static Boolean verifyShopifyHmac(String header, Blob body) {
        if (String.isBlank(header) || body == null) return false;
        String secret = getSharedSecret();
        if (String.isBlank(secret)) return false;
        String calc = EncodingUtil.base64Encode(Crypto.generateMac('HmacSHA256', body, Blob.valueOf(secret)));
        return calc == header;
    }

    private static String getSharedSecret() {
        Shopify_Config__c cs = Shopify_Config__c.getOrgDefaults();
        return (cs == null) ? null : cs.Webhook_Secret__c;
    }

    private static void log(String s) { System.debug('[ShopifyWebhook] ' + s); }
    private static String s(Object v) { return (v == null) ? null : String.valueOf(v); }
    private static Decimal d(Object v) { try { return (v == null) ? null : Decimal.valueOf(String.valueOf(v)); } catch (Exception e) { return null; } }
    private static Datetime dt(Object v) { try { return (v == null) ? null : (Datetime) JSON.deserialize('"' + String.valueOf(v) + '"', Datetime.class); } catch (Exception e) { return null; } }
}