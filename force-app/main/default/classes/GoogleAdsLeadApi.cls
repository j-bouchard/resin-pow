@RestResource(urlMapping='/googleadslead')
global without sharing class GoogleAdsLeadApi {
    
    global class GoogleAdsLead {
        public String lead_id;
        public List<UserColumnData> user_column_data;
        public String api_version;
        public Long form_id;
        public Long campaign_id;
        public String google_key;
        public Boolean is_test;
        public String gcl_id;
        public Long adgroup_id;
        public Long creative_id;
    }

    global class UserColumnData {
        public String column_name;
        public String string_value;
        public String column_id;
    }

    // Helper method to get a value by column name
    private static String getValueByColumnName(List<UserColumnData> userColumnDatalist, String name) {
        for (UserColumnData u : userColumnDatalist) {
            if (u.column_name == name) return u.string_value;
        }
        return null;
    }

    @HttpPost
    global static void handleLead() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            String requestBody = req.requestBody.toString();
            GoogleAdsLead lead = (GoogleAdsLead) JSON.deserialize(requestBody, GoogleAdsLead.class);

            if (lead == null || lead.user_column_data == null) {
                res.statusCode = 400;
                res.responseBody = Blob.valueOf('Invalid payload');
                return;
            }

            String email = getValueByColumnName(lead.user_column_data, 'User Email');
            String firstName = getValueByColumnName(lead.user_column_data, 'First Name');
            String lastName = String.isNotBlank(getValueByColumnName(lead.user_column_data, 'Last Name')) ? getValueByColumnName(lead.user_column_data, 'Last Name') : 'Pow';
            String city = getValueByColumnName(lead.user_column_data, 'City');
            String region = getValueByColumnName(lead.user_column_data, 'Region');
            String postalCode = getValueByColumnName(lead.user_column_data, 'Postal Code');

            if (email == null) {
                res.statusCode = 400;
                res.responseBody = Blob.valueOf('Email is required.');
                return;
            }

            List<Contact> existingContacts = [
                SELECT Id, FirstName, LastName, Email, MailingCity, MailingState, MailingPostalCode
                FROM Contact
                WHERE Email = :email
                LIMIT 1
            ];

            Id campaignId = [SELECT Id FROM Campaign WHERE Name = 'Google Ads - Join Team POW' LIMIT 1].Id;
			System.debug('campaignId ###' + campaignId);
            if (!existingContacts.isEmpty()) {
                Contact existing = existingContacts[0];
                existing.FirstName = firstName;
                existing.LastName = lastName;
                existing.City__c = city;
                existing.Region__c = region;
                existing.Postal_Code__c = postalCode;
				existing.Campaign__c = campaignId;
                
                update existing;
                res.statusCode = 200;
                res.responseBody = Blob.valueOf('Contact updated: ' + existing.Id);
            } else {
                Contact newContact = new Contact();
                newContact.FirstName = firstName;
                newContact.LastName = lastName;
                newContact.Email = email;
                newContact.City__c = city;
                newContact.Region__c = region;
                newContact.Postal_Code__c = postalCode;
                newContact.Campaign__c = campaignId;
				
                insert newContact;
                System.debug('newContact @@@' + newContact);
                res.statusCode = 201;
                res.responseBody = Blob.valueOf('New contact created: ' + newContact.Id);
            }
        } catch (Exception e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Error: ' + e.getMessage());
        }
    }
}