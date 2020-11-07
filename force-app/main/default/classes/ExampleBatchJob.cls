/**
 * Class: ExampleBatchJob.cls
 * Test:  ExampleBatchJobTest.cls
 * @desc: Example class to show how Batchable works. Salesforce documentation can be found at:
 *        https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_batch
 */
global class ExampleBatchJob implements Database.Batchable<sObject>, Database.Stateful {
    //  Ability to count records processed across transactions
    global Integer recordsProcessed = 0;

    /**
     * Query to get the records to work with
     */
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String databaseQuery = '';
        return Database.getQueryLocator( databaseQuery );
    }

    /**
     * Logic goes here
     */
    global void execute(Database.BatchableContext bc, List<Account> scope){
        //  Do stuff
        recordsProcessed += 1;
    }

    /**
     * Reporting goes here. E.g. Sending emails, create new records to report on batch
     */
    global void finish(Database.BatchableContext bc) {
        
    }
}