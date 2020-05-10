@isTest
private class AccountProcessorTest {

    @isTest
    static void testRunAllLines() {
        //  Setup
        List<Account> testAccounts = TestObjectFactory.createNTestAccounts(10, true);
        List<Contact> testContacts = new List<Contact>();
        List<Id> theAccountIds = new List<Id>();
        for (Account acc : testAccounts) {
            theAccountIds.add(acc.Id);
            Integer numOfContacts = Integer.valueOf(Math.random() * 5);
            testContacts.addAll(TestObjectFactory.createNTestContactsWithSameAccount(numOfContacts, acc.Id, false));
        }
        insert testContacts;

        //  Test code
        Test.startTest();
        AccountProcessor.countContacts(theAccountIds);
        Test.stopTest();
    
        //  Asserts
        //  Whoops I forgot to assert code
    }


}
