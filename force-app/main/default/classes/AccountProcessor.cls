/**
 * https://trailhead.salesforce.com/content/learn/modules/asynchronous_apex
 */
public with sharing class AccountProcessor {

    /**
     * This is a terrible way of doing things, but it is what Trailhead is asking for
     */
    @future
    public static void countContacts(List<Id> accountIds) {
        for (Id accId : accountIds) {
            Account acc = new Account(Id = accId);
            Integer numOfContacts = [SELECT Count() FROM Contact WHERE AccountId = :accId];
            acc.Number_Of_Contacts__c = numOfContacts;
            update acc;
        }
    }

}
