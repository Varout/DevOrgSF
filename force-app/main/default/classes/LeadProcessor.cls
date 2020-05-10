/**
 * https://trailhead.salesforce.com/content/learn/modules/asynchronous_apex
 */
global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{

    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id FROM Lead'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        for (Lead theLead : scope) {
            theLead.LeadSource = 'Dreamforce';
        }
        update scope;
        recordsProcessed += 1;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Records Processed: ' + String.valueOf(recordsProcessed));
    }


}
