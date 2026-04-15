@isTest
private class GoogleAdsLeadApiTest {

    // Helper method to build a mock JSON payload
    private static String getMockPayload(String email, String lastNameOverride) {
        String lastName = lastNameOverride != null ? lastNameOverride : 'LastName';

        return JSON.serialize(new Map<String, Object>{
            'lead_id' => 'TestLead123',
            'user_column_data' => new List<Object>{
                new Map<String, Object>{ 'column_name' => 'User Email', 'string_value' => email, 'column_id' => 'EMAIL' },
                new Map<String, Object>{ 'column_name' => 'First Name', 'string_value' => 'FirstName', 'column_id' => 'FIRST_NAME' },
                new Map<String, Object>{ 'column_name' => 'Last Name', 'string_value' => lastName, 'column_id' => 'LAST_NAME' },
                new Map<String, Object>{ 'column_name' => 'City', 'string_value' => 'Test City', 'column_id' => 'CITY' },
                new Map<String, Object>{ 'column_name' => 'Region', 'string_value' => 'Test State', 'column_id' => 'REGION' },
                new Map<String, Object>{ 'column_name' => 'Postal Code', 'string_value' => '12345', 'column_id' => 'POSTAL_CODE' }
            },
            'api_version' => '1.0',
            'form_id' => 123456789,
            'campaign_id' => 987654321,
            'google_key' => 'test-key',
            'is_test' => true,
            'gcl_id' => 'test-gclid',
            'adgroup_id' => 111,
            'creative_id' => 222
        });
    }

    private static void setupTestCampaign() {
        Campaign c = new Campaign(
            Name = 'Google Ads - Join Team POW',
            IsActive = true,
            StartDate = Date.today(),
            EndDate = Date.today().addDays(30),
            Type = 'Other',
			OKR_Type__c = 'Train'
        );
        insert c;
	}

    @isTest
    static void testCreateNewContact() {
        setupTestCampaign();

        RestRequest req = new RestRequest();
        req.httpMethod = 'POST';
        req.requestUri = '/services/apexrest/googleadslead';
        req.requestBody = Blob.valueOf(getMockPayload('new@example.com', null));
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        GoogleAdsLeadApi.handleLead();
        Test.stopTest();

        System.assertEquals(201, res.statusCode);
        System.assert(res.responseBody.toString().startsWith('New contact created:'));
    }

    @isTest
    static void testUpdateExistingContact() {
        setupTestCampaign();

        Contact existing = new Contact(
            FirstName = 'Old',
            LastName = 'Data',
            Email = 'existing@example.com'
        );
        insert existing;

        RestRequest req = new RestRequest();
        req.httpMethod = 'POST';
        req.requestUri = '/services/apexrest/googleadslead';
        req.requestBody = Blob.valueOf(getMockPayload('existing@example.com', 'UpdatedLastName'));
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        GoogleAdsLeadApi.handleLead();
        Test.stopTest();

        System.assertEquals(200, res.statusCode);
        System.assert(res.responseBody.toString().startsWith('Contact updated:'));

        Contact updated = [SELECT LastName FROM Contact WHERE Id = :existing.Id];
        System.assertEquals('Updatedlastname', updated.LastName);
    }

    @isTest
    static void testLastNameFallback() {
        setupTestCampaign();

        String payload = getMockPayload('fallback@example.com', '');

        RestRequest req = new RestRequest();
        req.httpMethod = 'POST';
        req.requestUri = '/services/apexrest/googleadslead';
        req.requestBody = Blob.valueOf(payload);
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        GoogleAdsLeadApi.handleLead();
        Test.stopTest();

        System.assertEquals(201, res.statusCode);

        Contact created = [SELECT LastName FROM Contact WHERE Email = 'fallback@example.com' LIMIT 1];
        System.assertEquals('Pow', created.LastName);
    }
    
    @isTest
    static void testMissingEmail() {
        setupTestCampaign();

        String payload = JSON.serialize(new Map<String, Object>{
            'lead_id' => 'MissingEmailTest',
            'user_column_data' => new List<Object>{
                new Map<String, Object>{ 'column_name' => 'First Name', 'string_value' => 'NoEmailFirst', 'column_id' => 'FIRST_NAME' },
                new Map<String, Object>{ 'column_name' => 'Last Name', 'string_value' => 'NoEmailLast', 'column_id' => 'LAST_NAME' },
                new Map<String, Object>{ 'column_name' => 'City', 'string_value' => 'NoEmailCity', 'column_id' => 'CITY' }
            },
            'api_version' => '1.0',
            'form_id' => 123456789,
            'campaign_id' => 987654321,
            'google_key' => 'test-key',
            'is_test' => true,
            'gcl_id' => 'test-gclid',
            'adgroup_id' => 111,
            'creative_id' => 222
        });

        RestRequest req = new RestRequest();
        req.httpMethod = 'POST';
        req.requestUri = '/services/apexrest/googleadslead';
        req.requestBody = Blob.valueOf(payload);
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        Test.startTest();
        GoogleAdsLeadApi.handleLead();
        Test.stopTest();

        System.assertEquals(400, res.statusCode);
        System.assertEquals('Email is required.', res.responseBody.toString());
    }
}