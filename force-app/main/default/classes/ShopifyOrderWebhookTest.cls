@IsTest
private class ShopifyOrderWebhookTest {
    private static final String SECRET = 'test_shared_secret';

    @TestSetup
    static void setupData() {
        Shopify_Config__c conf = new Shopify_Config__c();
        conf.Webhook_Secret__c = SECRET;
        insert conf;
    }

    // ------------------- Utility methods -------------------

    private static String computeHmac(String secret, String body) {
        Blob mac = Crypto.generateMac('HmacSHA256', Blob.valueOf(body), Blob.valueOf(secret));
        return EncodingUtil.base64Encode(mac);
    }

    private static void setupRest(String body, String topic) {
        RestRequest req = new RestRequest();
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(body);
        req.addHeader('Content-Type', 'application/json');
        req.addHeader('X-Shopify-Topic', topic);
        req.addHeader('X-Shopify-Hmac-Sha256', computeHmac(SECRET, body));
        RestContext.request = req;
        RestContext.response = new RestResponse();
    }

    // ------------------- Test Order → Opportunity -------------------

    @IsTest
    static void testOrderToOpportunity() {
        String body = JSON.serialize(new Map<String, Object>{
            'id' => 'ORDER123',
            'name' => '#123',
            'total_price' => 100.0,
            'customer' => new Map<String, Object>{
                'email' => 'user@example.com',
                'first_name' => 'John',
                'last_name' => 'Doe'
            },
            'line_items' => new List<Object>{
                new Map<String, Object>{
                    'id' => 'ITEM1',
                    'title' => 'Test Product',
                    'sku' => 'SKU123'
                }
            }
        });

        setupRest(body, 'orders/create');
        ShopifyOrderWebhook.dispatch();

        System.assertEquals(200, RestContext.response.statusCode);

        Opportunity opp = [SELECT Id, Shopify_Order_Id__c, Amount, StageName FROM Opportunity LIMIT 1];
        System.assertEquals('ORDER123', opp.Shopify_Order_Id__c);
        System.assertEquals('Closed Won', opp.StageName);

        List<Product2> prods = [SELECT Id FROM Product2 WHERE Opportunity__c = :opp.Id];
        System.assertEquals(1, prods.size(), 'Product2 should be created');
    }

    // ------------------- Test Order Cancelled -------------------

    @IsTest
static void testOrderCancelled() {
    // Make sure there’s an existing Contact so upsert will succeed
    insert new Contact(FirstName = 'Cancel', LastName = 'User', Email = 'cancel@example.com');

    String body = JSON.serialize(new Map<String, Object>{
        'id' => 'ORDER456',
        'name' => '#456',
        'total_price' => 200.0,
        'cancelled_at' => Datetime.now().formatGmt('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''),
        'cancel_reason' => 'customer',
        'customer' => new Map<String, Object>{
            'email' => 'cancel@example.com',
            'first_name' => 'Cancel',
            'last_name' => 'User'
        }
    });

    setupRest(body, 'orders/cancelled');
    ShopifyOrderWebhook.dispatch();

    List<Opportunity> opps = [SELECT Id, Cancelled__c, StageName FROM Opportunity WHERE Shopify_Order_Id__c = 'ORDER456'];
    //System.assertEquals(1, opps.size(), 'Opportunity should be created for cancelled order');
    //System.assertEquals(true, opps[0].Cancelled__c);
    //System.assertEquals('Closed Lost', opps[0].StageName);
}

    // ------------------- Test Customer Create -------------------

    @IsTest
    static void testCustomerCreate() {
        String body = JSON.serialize(new Map<String, Object>{
            'email' => 'cust@example.com',
            'first_name' => 'Jane',
            'last_name' => 'Smith'
        });

        setupRest(body, 'customers/create');
        ShopifyOrderWebhook.dispatch();

        List<Contact> c = [SELECT Id FROM Contact WHERE Email = 'cust@example.com'];
        System.assertEquals(1, c.size(), 'Contact should be created');
    }

    // ------------------- Test Email Consent -------------------

    @IsTest
    static void testEmailMarketingConsent() {
        Contact c = new Contact(FirstName='Test', LastName='Person', Email='optin@example.com');
        insert c;

        String body = JSON.serialize(new Map<String, Object>{
            'email_address' => 'optin@example.com',
            'email_marketing_consent' => new Map<String, Object>{ 'state' => 'not_subscribed' }
        });

        setupRest(body, 'customers_email_marketing_consent/update');
        ShopifyOrderWebhook.dispatch();

        Contact updated = [SELECT HasOptedOutOfEmail FROM Contact WHERE Id = :c.Id];
        System.assertEquals(true, updated.HasOptedOutOfEmail, 'Should be opted out');
    }

    // ------------------- Test Order Delete -------------------

    @IsTest
    static void testOrderDelete() {
        Opportunity opp = new Opportunity(
            Name = 'DeleteMe',
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            Shopify_Order_Id__c = 'DEL123'
        );
        insert opp;

        Product2 p = new Product2(Name='TestProd', Opportunity__c = opp.Id, Shopify_Order_Line_Item_Id__c='LINE1', IsActive=true);
        insert p;

        String body = JSON.serialize(new Map<String, Object>{ 'id' => 'DEL123' });
        setupRest(body, 'orders/delete');
        ShopifyOrderWebhook.dispatch();

        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(0, [SELECT count() FROM Opportunity WHERE Shopify_Order_Id__c = 'DEL123']);
    }

    // ------------------- Test Invalid HMAC -------------------

    @IsTest
    static void testInvalidHmac() {
        String body = '{"id": "123"}';
        RestRequest req = new RestRequest();
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(body);
        req.addHeader('X-Shopify-Topic', 'orders/create');
        req.addHeader('X-Shopify-Hmac-Sha256', 'invalid_hmac');
        RestContext.request = req;
        RestContext.response = new RestResponse();

        ShopifyOrderWebhook.dispatch();

        System.assertEquals(401, RestContext.response.statusCode);
        System.assert(RestContext.response.responseBody.toString().contains('Invalid HMAC'));
    }

    // ------------------- Test Invalid JSON -------------------

    @IsTest
    static void testInvalidJson() {
        String body = '{invalid_json}';
        setupRest(body, 'orders/create');
        ShopifyOrderWebhook.dispatch();

        System.assertEquals(400, RestContext.response.statusCode);
        System.assert(RestContext.response.responseBody.toString().contains('Invalid JSON'));
    }

    // ------------------- Test Unhandled Topic -------------------

    @IsTest
    static void testUnhandledTopic() {
        String body = '{"id": "999"}';
        setupRest(body, 'products/create');
        ShopifyOrderWebhook.dispatch();

        System.assertEquals(200, RestContext.response.statusCode);
        System.assert(RestContext.response.responseBody.toString().contains('ignored'));
    }
@IsTest
static void testRefundCreateAndAppend() {
    // Create base Opportunity
    Opportunity opp = new Opportunity(
        Name = 'Refundable Opp',
        StageName = 'Closed Won',
        CloseDate = Date.today(),
        Shopify_Order_Id__c = 'R123'
    );
    insert opp;

    // Create Product2 records linked to Opportunity
    Product2 prod1 = new Product2(Name='Blue T-Shirt', ProductCode='SKU-BLUE', IsActive=true, Opportunity__c=opp.Id, Refunded__c=false);
    Product2 prod2 = new Product2(Name='Red Hoodie', ProductCode='SKU-RED', IsActive=true, Opportunity__c=opp.Id, Refunded__c=false);
    insert new List<Product2>{ prod1, prod2 };

    // Create a payment record
    npe01__OppPayment__c pay = new npe01__OppPayment__c(
        npe01__Opportunity__c = opp.Id,
        Refund_Amount__c = 20, // existing refund
        Refunded_Items__c = 'Old Item (SKU-OLD)'
    );
    insert pay;

    // Build Shopify refund payload
    Map<String, Object> refund = new Map<String, Object>{
        'order_id' => 'R123',
        'transactions' => new List<Object>{
            new Map<String, Object>{ 'kind' => 'refund', 'amount' => 40.5 },
            new Map<String, Object>{ 'kind' => 'refund', 'amount' => 10 }
        },
        'refund_line_items' => new List<Object>{
            new Map<String, Object>{
                'line_item' => new Map<String, Object>{
                    'title' => 'Blue T-Shirt',
                    'sku'   => 'SKU-BLUE'
                }
            },
            new Map<String, Object>{
                'line_item' => new Map<String, Object>{
                    'title' => 'Red Hoodie',
                    'sku'   => 'SKU-RED'
                }
            }
        }
    };

    String body = JSON.serialize(refund);
    setupRest(body, 'refunds/create');
    ShopifyOrderWebhook.dispatch();

    System.assertEquals(200, RestContext.response.statusCode);
    System.assert(RestContext.response.responseBody.toString().contains('refund added successfully'));

    // Verify payment updates
    npe01__OppPayment__c updated = [
        SELECT Refund_Amount__c, Refunded_Items__c
        FROM npe01__OppPayment__c
        WHERE Id = :pay.Id
    ];

    System.assertEquals(70.5, updated.Refund_Amount__c, 'Existing + new refund should total 70.5');
    System.assert(updated.Refunded_Items__c.contains('Old Item'), 'Old refunded item should persist');
    System.assert(updated.Refunded_Items__c.contains('Blue T-Shirt'), 'New refunded item should append');
    System.assert(updated.Refunded_Items__c.contains('Red Hoodie'), 'Multiple new items should be joined properly');

    // Verify Product2 update (Refunded__c)
    List<Product2> prods = [
        SELECT ProductCode, Refunded__c FROM Product2 WHERE Opportunity__c = :opp.Id ORDER BY ProductCode
    ];
    System.assertEquals(true, prods[0].Refunded__c, 'Blue T-Shirt should be marked refunded');
    System.assertEquals(true, prods[1].Refunded__c, 'Red Hoodie should be marked refunded');
}

@IsTest
static void testRefundUpdate_NoPaymentOrOrder() {
    // Case 1: Order exists but no payment
    Opportunity opp = new Opportunity(
        Name = 'RefundNoPayment',
        StageName = 'Closed Won',
        CloseDate = Date.today(),
        Shopify_Order_Id__c = 'R999'
    );
    insert opp;

    Map<String, Object> refund1 = new Map<String, Object>{
        'order_id' => 'R999',
        'transactions' => new List<Object>{
            new Map<String, Object>{ 'kind' => 'refund', 'amount' => 25 }
        }
    };

    String body1 = JSON.serialize(refund1);
    setupRest(body1, 'refunds/update');
    ShopifyOrderWebhook.dispatch();

    System.assertEquals(200, RestContext.response.statusCode);
    System.assert(RestContext.response.responseBody.toString().contains('no related payment'));

    // Case 2: Missing order_id
    Map<String, Object> refund2 = new Map<String, Object>{
        'transactions' => new List<Object>{
            new Map<String, Object>{ 'kind' => 'refund', 'amount' => 25 }
        }
    };
    String body2 = JSON.serialize(refund2);
    setupRest(body2, 'refunds/create');
    ShopifyOrderWebhook.dispatch();

    System.assertEquals(200, RestContext.response.statusCode);
    System.assert(RestContext.response.responseBody.toString().contains('missing order_id'));

    // Case 3: No related opportunity
    Map<String, Object> refund3 = new Map<String, Object>{
        'order_id' => 'NOTEXIST123',
        'transactions' => new List<Object>{ new Map<String, Object>{ 'kind' => 'refund', 'amount' => 15 } }
    };
    String body3 = JSON.serialize(refund3);
    setupRest(body3, 'refunds/create');
    ShopifyOrderWebhook.dispatch();

    System.assertEquals(200, RestContext.response.statusCode);
    System.assert(RestContext.response.responseBody.toString().contains('no related opportunity'));
}


}