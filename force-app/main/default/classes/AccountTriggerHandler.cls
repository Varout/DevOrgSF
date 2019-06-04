public with sharing class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> accountsToInsert) {
        
        for (Account acc : accountsToInsert) {
            if (acc.ShippingState != acc.BillingState) {
	            acc.ShippingState = acc.BillingState;
            }
        }
        
    }
    
}