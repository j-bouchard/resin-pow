@isTest
private class CiviClickWebhookHandlerTest {
    
    @testSetup
    static void setupTestData() {
        // Create a test campaign
        Campaign testCampaign = new Campaign(
            Name = 'Test CiviClick Campaign',
            CiviClick_Campaign_ID__c = '9999',
            IsActive = true
        );
        insert testCampaign;
        
        // Create an existing contact with CiviClick ID
        Contact existingAdvocate = new Contact(
            FirstName = 'Existing',
            LastName = 'Advocate',
            Email = 'existing@example.com',
            CiviClick_Advocate_ID__c = '1111111',
            CiviClick_Email__c = 'existing@example.com'
        );
        insert existingAdvocate;
        
        // Create a contact with email only (no CiviClick ID)
        Contact emailOnlyContact = new Contact(
            FirstName = 'Email',
            LastName = 'Only',
            Email = 'emailonly@example.com'
        );
        insert emailOnlyContact;
    }
    
    @isTest
    static void testNewAdvocateNewCampaign() {
        // Test creating a brand new advocate and campaign
        String jsonPayload = '{' +
            '"submission": {' +
                '"campaign_id": 12345,' +
                '"campaign_name": "New Test Campaign",' +
                '"response_type": "Petition",' +
                '"id": 99999,' +
                '"start_date": "2025-01-01",' +
                '"end_date": "2025-12-31"' +
            '},' +
            '"advocate": {' +
                '"id": 2222222,' +
                '"first_name": "New",' +
                '"last_name": "Person",' +
                '"email": "newperson@example.com",' +
                '"street_address1": "123 Main St",' +
                '"city": "Denver",' +
                '"state": "CO",' +
                '"zip": "80202",' +
                '"country": "US",' +
                '"phone": 5551234567' +
            '},' +
            '"New_Advocate": true' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'Webhook should succeed');
        
        // Verify contact was created
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, CiviClick_Advocate_ID__c 
                                  FROM Contact WHERE Email = 'newperson@example.com'];
        System.assertEquals(1, contacts.size(), 'New contact should be created');
        System.assertEquals('2222222', contacts[0].CiviClick_Advocate_ID__c, 'Advocate ID should be set');
        
        // Verify campaign was created with correct type and dates
        List<Campaign> campaigns = [SELECT Id, Name, Type, StartDate, EndDate FROM Campaign WHERE CiviClick_Campaign_ID__c = '12345'];
        System.assertEquals(1, campaigns.size(), 'New campaign should be created');
        System.assertEquals('Petition', campaigns[0].Type, 'Campaign type should match CiviClick response_type');
        System.assertEquals(Date.valueOf('2025-01-01'), campaigns[0].StartDate, 'Campaign start date should be set');
        System.assertEquals(Date.valueOf('2025-12-31'), campaigns[0].EndDate, 'Campaign end date should be set');
    }
    
    @isTest
    static void testExistingAdvocateById() {
        // Test matching existing advocate by CiviClick ID
        String jsonPayload = '{' +
            '"submission": {' +
                '"campaign_id": 9999,' +
                '"campaign_name": "Test CiviClick Campaign",' +
                '"response_type": "Petition",' +
                '"id": 88888' +
            '},' +
            '"advocate": {' +
                '"id": 1111111,' +
                '"first_name": "Updated",' +
                '"last_name": "Name",' +
                '"email": "updated@example.com"' +
            '},' +
            '"New_Advocate": false' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'Webhook should succeed');
        
        // Verify existing contact was updated (matched by CiviClick ID)
        Contact updated = [SELECT Id, FirstName, CiviClick_Email__c FROM Contact WHERE CiviClick_Advocate_ID__c = '1111111'];
        System.assertEquals('updated@example.com', updated.CiviClick_Email__c, 'CiviClick email should be updated');
    }
    
    @isTest
    static void testExistingContactByEmail() {
        // Test matching existing contact by email (no CiviClick ID yet)
        String jsonPayload = '{' +
            '"submission": {' +
                '"campaign_id": 9999,' +
                '"campaign_name": "Test CiviClick Campaign",' +
                '"response_type": "Email",' +
                '"id": 77777' +
            '},' +
            '"advocate": {' +
                '"id": 3333333,' +
                '"first_name": "Email",' +
                '"last_name": "Only",' +
                '"email": "emailonly@example.com"' +
            '},' +
            '"New_Advocate": false' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'Webhook should succeed');
        
        // Verify CiviClick ID was added to existing contact
        Contact updated = [SELECT Id, CiviClick_Advocate_ID__c FROM Contact WHERE Email = 'emailonly@example.com'];
        System.assertEquals('3333333', updated.CiviClick_Advocate_ID__c, 'Advocate ID should be populated');
    }
    
    @isTest
    static void testStateAndCountryMapping() {
        // Test with various state/country codes
        String jsonPayload = '{' +
            '"submission": {' +
                '"campaign_id": 9999,' +
                '"campaign_name": "Test CiviClick Campaign",' +
                '"response_type": "Petition",' +
                '"id": 66666' +
            '},' +
            '"advocate": {' +
                '"id": 4444444,' +
                '"first_name": "State",' +
                '"last_name": "Test",' +
                '"email": "statetest@example.com",' +
                '"state": "NH",' +
                '"country": "US"' +
            '},' +
            '"New_Advocate": true' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'Webhook should succeed');
        
        // Verify state/country were mapped correctly
        Contact created = [SELECT Id, MailingState, MailingCountry FROM Contact WHERE Email = 'statetest@example.com'];
        System.assertEquals('New Hampshire', created.MailingState, 'State should be mapped to full name');
        System.assertEquals('United States of America', created.MailingCountry, 'Country should be mapped to full name');
    }
    
    @isTest
    static void testCampaignMemberCreation() {
        // Verify campaign member is created
        String jsonPayload = '{' +
            '"submission": {' +
                '"campaign_id": 9999,' +
                '"campaign_name": "Test CiviClick Campaign",' +
                '"response_type": "Petition",' +
                '"id": 55555' +
            '},' +
            '"advocate": {' +
                '"id": 5555555,' +
                '"first_name": "Campaign",' +
                '"last_name": "Member",' +
                '"email": "campaignmember@example.com"' +
            '},' +
            '"New_Advocate": true' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'Webhook should succeed');
        
        // Verify campaign member was created
        Contact c = [SELECT Id FROM Contact WHERE Email = 'campaignmember@example.com'];
        Campaign camp = [SELECT Id FROM Campaign WHERE CiviClick_Campaign_ID__c = '9999'];
        
        List<CampaignMember> members = [SELECT Id FROM CampaignMember WHERE ContactId = :c.Id AND CampaignId = :camp.Id];
        System.assertEquals(1, members.size(), 'Campaign member should be created');
    }
    
    @isTest
    static void testInvalidPayload() {
        // Test with invalid JSON
        String jsonPayload = 'not valid json';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(false, response.success, 'Webhook should return error for invalid JSON');
    }
    
    @isTest
    static void testMissingEmail() {
        // Test with missing email
        String jsonPayload = '{' +
            '"submission": {' +
                '"campaign_id": 9999,' +
                '"campaign_name": "Test Campaign",' +
                '"id": 44444' +
            '},' +
            '"advocate": {' +
                '"id": 6666666,' +
                '"first_name": "No",' +
                '"last_name": "Email"' +
            '},' +
            '"New_Advocate": true' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(false, response.success, 'Webhook should fail for missing email');
    }
    
    @isTest
    static void testNullSubmission() {
        // Test with null submission (only advocate data)
        String jsonPayload = '{' +
            '"advocate": {' +
                '"id": 7777777,' +
                '"first_name": "Only",' +
                '"last_name": "Advocate",' +
                '"email": "onlyadvocate@example.com"' +
            '},' +
            '"New_Advocate": true' +
        '}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/civiclick/webhook';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonPayload);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        CiviClickWebhookHandler.WebhookResponse response = CiviClickWebhookHandler.handleWebhook();
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'Webhook should succeed even without submission');
        
        // Contact should still be created
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Email = 'onlyadvocate@example.com'];
        System.assertEquals(1, contacts.size(), 'Contact should be created');
    }
}