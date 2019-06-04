@isTest
private class AccountTriggerTest {

    @isTest 
    static void testStatesStringValue() {
        
        //	Create 200 accounts
        List<Account> accts = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i);
            acct.BillingState = 'CA';
            accts.add(acct);
        }

        System.debug('Account before insert: ' + accts.size());
        Test.StartTest();
            insert accts;
        Test.StopTest();
        
        accts = [SELECT Id, BillingState, ShippingState FROM Account];
        System.debug('Accounts post insert: ' + accts.size());
        
        Integer accTestCounter = 0;
        for (Account acc : accts) {
            System.assertEquals(acc.BillingState, acc.ShippingState);
            accTestCounter++;
        }
		System.debug('Number of accs tested: ' + accTestCounter);
        
        
    }
    
}