@isTest
public class UpdateCountryBatchTest {

    @isTest
    static void testBatchUpdateCountry() {

        // Create test contacts
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                LastName = 'Test ' + i,
                MailingCountry = 'United States'
            ));
        }
        insert testContacts;

        // Run the batch
        Test.startTest();
        UpdateCountryBatch batchJob = new UpdateCountryBatch();
        Database.executeBatch(batchJob, 200);
        Test.stopTest();

        // Query updated contacts
        List<Contact> updatedContacts = [
            SELECT MailingCountry FROM Contact
            WHERE Id IN :testContacts
        ];

        // Assert values
        for(Contact c : updatedContacts) {
            System.assertEquals('United States of America', c.MailingCountry, 'MailingCountry should have been updated');
        }
    }
}