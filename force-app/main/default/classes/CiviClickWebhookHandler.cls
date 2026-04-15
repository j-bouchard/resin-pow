@RestResource(urlMapping='/civiclick/webhook')
global without sharing class CiviClickWebhookHandler {
    
    @HttpPost
    global static WebhookResponse handleWebhook() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        WebhookResponse response = new WebhookResponse();
        
        try {
            String requestBody = req.requestBody.toString();
            
            System.debug(LoggingLevel.DEBUG, 'CiviClick Raw Payload: ' + requestBody);
            
            CiviClickPayload payload = (CiviClickPayload) JSON.deserialize(
                requestBody, 
                CiviClickPayload.class
            );
            
            System.debug(LoggingLevel.DEBUG, 'Parsed advocate: ' + payload.advocate);
            System.debug(LoggingLevel.DEBUG, 'Parsed submission: ' + payload.submission);
            
            Contact advocate = upsertAdvocate(payload.advocate);
            processSubmission(payload.submission, advocate.Id);
            
            response.success = true;
            response.message = 'Webhook processed successfully';
            response.contactId = advocate.Id;
            res.statusCode = 200;
            
        } catch (Exception e) {
            response.success = false;
            response.message = e.getMessage();
            response.stackTrace = e.getStackTraceString();
            res.statusCode = 500;
            
            System.debug(LoggingLevel.ERROR, 'CiviClick Webhook Error: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack: ' + e.getStackTraceString());
        }
        
        return response;
    }
    
    private static Contact upsertAdvocate(AdvocateData advocate) {
        if (advocate == null || String.isBlank(advocate.email)) {
            throw new CiviClickException('Advocate email is required');
        }
        
        String advocateId = advocate.id != null ? String.valueOf(advocate.id) : null;
        String email = advocate.email;
        
        Contact c = null;
        
        // Step 1: Try to match on CiviClick_Advocate_ID__c first
        if (String.isNotBlank(advocateId)) {
            List<Contact> matchedById = [
                SELECT Id, FirstName, LastName, Email, CiviClick_Advocate_ID__c, CiviClick_Email__c,
                       npe01__AlternateEmail__c, npe01__HomeEmail__c, npe01__WorkEmail__c
                FROM Contact
                WHERE CiviClick_Advocate_ID__c = :advocateId
                LIMIT 1
            ];
            if (!matchedById.isEmpty()) {
                c = matchedById[0];
                System.debug(LoggingLevel.INFO, 'Matched contact by Advocate ID: ' + c.Id);
            }
        }
        
        // Step 2: If no match, try to match on any email field
        if (c == null && String.isNotBlank(email)) {
            List<Contact> matchedByEmail = [
                SELECT Id, FirstName, LastName, Email, CiviClick_Advocate_ID__c, CiviClick_Email__c,
                       npe01__AlternateEmail__c, npe01__HomeEmail__c, npe01__WorkEmail__c
                FROM Contact
                WHERE Email = :email
                   OR npe01__AlternateEmail__c = :email
                   OR npe01__HomeEmail__c = :email
                   OR npe01__WorkEmail__c = :email
                LIMIT 1
            ];
            if (!matchedByEmail.isEmpty()) {
                c = matchedByEmail[0];
                System.debug(LoggingLevel.INFO, 'Matched contact by Email: ' + c.Id);
            }
        }
        
        // Step 3: If still no match, create new Contact
        if (c == null) {
            c = new Contact();
            System.debug(LoggingLevel.INFO, 'Creating new contact for: ' + email);
        }
        
        // Update fields — only set Advocate ID if we have one
        if (String.isNotBlank(advocateId)) {
            c.CiviClick_Advocate_ID__c = advocateId;
        }
        c.CiviClick_Email__c = email;
        c.Email = email;
        c.FirstName = advocate.first_name;
        c.LastName = advocate.last_name;
        c.Salutation = advocate.prefix;
        c.MailingStreet = advocate.street_address1;
        c.MailingCity = advocate.city;
        c.MailingState = mapState(advocate.state);
        c.MailingPostalCode = advocate.zip;
        c.MailingCountry = mapCountry(advocate.country);
        
        // Handle phone as either String or Long
        if (advocate.phone != null) {
            c.Phone = String.valueOf(advocate.phone);
        }
        
        if (c.Id != null) {
            update c;
        } else {
            insert c;
        }
        
        System.debug(LoggingLevel.INFO, 'Upserted contact: ' + c.Id);
        return c;
    }
    
    private static String mapCountry(String countryCode) {
        if (String.isBlank(countryCode)) return null;
        
        Map<String, String> countryMap = new Map<String, String>{
            'US' => 'United States of America',
            'USA' => 'United States of America',
            'CA' => 'Canada',
            'AU' => 'Australia',
            'UK' => 'United Kingdom',
            'GB' => 'United Kingdom'
        };
        
        return countryMap.containsKey(countryCode.toUpperCase()) 
            ? countryMap.get(countryCode.toUpperCase()) 
            : countryCode;
    }
    
    private static String mapState(String stateCode) {
        if (String.isBlank(stateCode)) return null;
        
        // US States
        Map<String, String> stateMap = new Map<String, String>{
            'AL' => 'Alabama',
            'AK' => 'Alaska',
            'AZ' => 'Arizona',
            'AR' => 'Arkansas',
            'CA' => 'California',
            'CO' => 'Colorado',
            'CT' => 'Connecticut',
            'DE' => 'Delaware',
            'FL' => 'Florida',
            'GA' => 'Georgia',
            'HI' => 'Hawaii',
            'ID' => 'Idaho',
            'IL' => 'Illinois',
            'IN' => 'Indiana',
            'IA' => 'Iowa',
            'KS' => 'Kansas',
            'KY' => 'Kentucky',
            'LA' => 'Louisiana',
            'ME' => 'Maine',
            'MD' => 'Maryland',
            'MA' => 'Massachusetts',
            'MI' => 'Michigan',
            'MN' => 'Minnesota',
            'MS' => 'Mississippi',
            'MO' => 'Missouri',
            'MT' => 'Montana',
            'NE' => 'Nebraska',
            'NV' => 'Nevada',
            'NH' => 'New Hampshire',
            'NJ' => 'New Jersey',
            'NM' => 'New Mexico',
            'NY' => 'New York',
            'NC' => 'North Carolina',
            'ND' => 'North Dakota',
            'OH' => 'Ohio',
            'OK' => 'Oklahoma',
            'OR' => 'Oregon',
            'PA' => 'Pennsylvania',
            'RI' => 'Rhode Island',
            'SC' => 'South Carolina',
            'SD' => 'South Dakota',
            'TN' => 'Tennessee',
            'TX' => 'Texas',
            'UT' => 'Utah',
            'VT' => 'Vermont',
            'VA' => 'Virginia',
            'WA' => 'Washington',
            'WV' => 'West Virginia',
            'WI' => 'Wisconsin',
            'WY' => 'Wyoming',
            'DC' => 'District of Columbia',
            'PR' => 'Puerto Rico',
            'VI' => 'Virgin Islands',
            'GU' => 'Guam',
            'AS' => 'American Samoa',
            'MP' => 'Northern Mariana Islands',
            // Canadian Provinces
            'AB' => 'Alberta',
            'BC' => 'British Columbia',
            'MB' => 'Manitoba',
            'NB' => 'New Brunswick',
            'NL' => 'Newfoundland and Labrador',
            'NS' => 'Nova Scotia',
            'NT' => 'Northwest Territories',
            'NU' => 'Nunavut',
            'ON' => 'Ontario',
            'PE' => 'Prince Edward Island',
            'QC' => 'Quebec',
            'SK' => 'Saskatchewan',
            'YT' => 'Yukon'
        };
        
        return stateMap.containsKey(stateCode.toUpperCase()) 
            ? stateMap.get(stateCode.toUpperCase()) 
            : stateCode;
    }
    
    private static void processSubmission(SubmissionData submission, Id contactId) {
        System.debug(LoggingLevel.DEBUG, 'processSubmission called - submission: ' + submission);

        if (submission == null) {
            System.debug(LoggingLevel.INFO, 'No submission data, skipping campaign processing');
            return;
        }

        if (submission.campaign_id == null) {
            System.debug(LoggingLevel.WARN, 'Submission has no campaign_id, skipping campaign processing');
            return;
        }

        Id campaignId = getOrCreateCampaign(submission);

        if (campaignId == null) {
            System.debug(LoggingLevel.ERROR, 'Failed to get or create campaign for CiviClick campaign_id: ' + submission.campaign_id);
            return;
        }

        List<CampaignMember> existingMembers = [
            SELECT Id
            FROM CampaignMember
            WHERE CampaignId = :campaignId AND ContactId = :contactId
            LIMIT 1
        ];

        if (existingMembers.isEmpty()) {
            CampaignMember cm = new CampaignMember();
            cm.CampaignId = campaignId;
            cm.ContactId = contactId;
            cm.Status = 'Responded';
            insert cm;
            System.debug(LoggingLevel.INFO, 'Created CampaignMember: ' + cm.Id);
        } else {
            System.debug(LoggingLevel.DEBUG, 'CampaignMember already exists, skipping');
        }
    }
    
    private static Id getOrCreateCampaign(SubmissionData submission) {
        String civiClickId = String.valueOf(submission.campaign_id);

        List<Campaign> existingCampaigns = [
            SELECT Id
            FROM Campaign
            WHERE CiviClick_Campaign_ID__c = :civiClickId
            LIMIT 1
        ];

        if (!existingCampaigns.isEmpty()) {
            System.debug(LoggingLevel.INFO, 'Found existing campaign: ' + existingCampaigns[0].Id);
            return existingCampaigns[0].Id;
        }

        Campaign newCampaign = new Campaign();
        newCampaign.Name = String.isNotBlank(submission.campaign_name)
            ? submission.campaign_name
            : 'CiviClick Campaign ' + civiClickId;
        newCampaign.CiviClick_Campaign_ID__c = civiClickId;
        newCampaign.IsActive = true;
        newCampaign.Status = 'In Progress';

        // Use response_type from CiviClick (e.g. Petition, Letter, Email)
        if (String.isNotBlank(submission.response_type)) {
            newCampaign.Type = submission.response_type;
        }

        // Map campaign dates from submission
        if (String.isNotBlank(submission.start_date)) {
            newCampaign.StartDate = Date.valueOf(submission.start_date);
        }
        if (String.isNotBlank(submission.end_date)) {
            newCampaign.EndDate = Date.valueOf(submission.end_date);
        }

        insert newCampaign;
        System.debug(LoggingLevel.INFO, 'Created campaign: ' + newCampaign.Id + ' Type: ' + newCampaign.Type);
        return newCampaign.Id;
    }
    
    // Wrapper classes matching actual CiviClick payload structure
    global class CiviClickPayload {
        public AdvocateData advocate;
        public SubmissionData submission;
        public Boolean New_Advocate;
    }
    
    global class AdvocateData {
        public Long id;
        public String email;
        public String prefix;
        public String first_name;
        public String last_name;
        public Long phone;  // CiviClick sends phone as a number
        public String street_address1;
        public String city;
        public String state;
        public String zip;
        public String country;
        public String Congressional_District;
        public String State_Senate_District;
        public String state_house_district;
        public Boolean active;
        public Boolean privacy_opt_in;
    }
    
    global class SubmissionData {
        public Long id;
        public Long campaign_id;
        public String campaign_name;
        public String campaign_uuid;
        public String response_type;
        public String start_date;
        public String end_date;
        public String country;
        public String state;
        public String cong_district;
        public Boolean is_sms_optin;
        public Boolean send_email_updates;
        public Boolean privacy_opt_in;
        public String advocate_names;
    }
    
    global class WebhookResponse {
        public Boolean success;
        public String message;
        public String contactId;
        public String stackTrace;
    }
    
    public class CiviClickException extends Exception {}
}