public class UpdateCountryBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, MailingCountry FROM Contact WHERE MailingCountry = \'United States\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for(Contact c : scope) {
            c.MailingCountry = 'United States of America';
        }

        if(!scope.isEmpty()) {
            update scope;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Optional: send email or do logging
        System.debug('Batch completed successfully');
    }
}