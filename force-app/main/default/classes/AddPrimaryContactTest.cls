/**
 * 
 */
@isTest
private class AddPrimaryContactTest {
    @testSetup
    static void makeData() {
        List<Account> testAccountsFirst = TestObjectFactory.createNTestAccounts(50, false);
        for (Account acc : testAccountsFirst) {
            acc.BillingState = 'NY';
        }
        List<Account> testAccountsSecond = TestObjectFactory.createNTestAccounts(50, false);
        for (Account acc : testAccountsSecond) {
            acc.BillingState = 'CA';
        }

        List<Account> accsToInsert = new List<Account>();
        accsToInsert.addAll(testAccountsFirst);
        accsToInsert.addAll(testAccountsSecond);
        try {
            insert accsToInsert;
            System.debug('Account insert success');
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }

    @isTest
    static void testOne() {
        Contact testContact = new Contact();
        testContact.FirstName = 'Inigo';
        testContact.LastName = 'Monotoya';

        AddPrimaryContact addPCon = new AddPrimaryContact(testContact, 'CA');
        Test.startTest();
        System.enqueueJob(addPCon);
        Test.stopTest();

        List<Contact> resultContacts = [SELECT Id, AccountId, Account.BillingState FROM Contact];
        System.assertEquals(50, resultContacts.size());
        for (Contact c : resultContacts) {
            System.assertEquals('CA', c.Account.BillingState);
        }
    }
}