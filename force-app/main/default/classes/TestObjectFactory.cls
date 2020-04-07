/**
 * Class: TestObjectFactory
 * @desc: Contains methods to create test data.  All methods should be static.
 */
public class TestObjectFactory {

    final private static SObjectUtil OBJ_UTIL_ACCOUNT = new SObjectUtil('Account');
    final private static SObjectUtil OBJ_UTIL_CONTACT = new SObjectUtil('Contact');
    final private static SObjectUtil OBJ_UTIL_DESIRE  = new SObjectUtil('Desire__c');

    /* **************************************************  */
    /*                    Account                          */
    /* **************************************************  */

    /**
     * Creates a new account for testing
     * @param   String. Name of the account
     * @param   Boolean. Whether or not to insert the account record
     * @return  Account. The test account record
     */
    public static Account createTestAccount(String name, Boolean doInsert) {
        Account testAccount = new Account();
        testAccount.Name = name;

        if (doInsert) {
            insert testAccount;
        }

        return testAccount;
    }

    /**
     * Creates N number of test accounts
     * @param   Integer. Number of accounts to create
     * @param   Boolean. Whether or not to insert the accounts
     * @return  List<Account>. The test account records as a list
     */
    public static List<Account> createNTestAccounts(Integer numberToCreate, Boolean doInsert) {
        List<Account> testAccounts = new List<Account>();
        //  Make sure the requested number to create is positive
        if (numberToCreate <= 0) {
            return testAccounts;
        }

        //  Create the accounts
        for (Integer accCounter = 0; accCounter < numberToCreate; accCounter++) {
            String accName = 'Test Account ' + String.valueOf(accCounter + 1);
            testAccounts.add(createTestAccount(accName, false));
        }

        if (doInsert) {
            insert testAccounts;
        }

        return testAccounts;
    }

    /* **************************************************  */
    /*                    Contact                          */
    /* **************************************************  */

    /**
     * Creates a new contact for testing
     * @param   String. The first name of the contact
     * @param   String. The last name of the contact
     * @param   Id. Id of the linked account
     * @param   Boolean. Whether or not to insert the contact record
     * @return  Contact. The test contact record
     */
    public static Contact createTestContact(String firstName, String lastName, Id accountId, Boolean doInsert) {
        Contact testContact = new Contact();

        testContact.FirstName = firstName;
        testContact.LastName  = lastName;
        testContact.AccountId = accountId;

        if (doInsert) {
            insert testContact;
        }

        return testContact;
    }

    /**
     * Creates a new contact for testing along with a linked test account record
     * @param   String. The first name of the contact
     * @param   String. The last name of the contact
     * @param   Boolean. Whether or not to insert the contact record
     * @return  Contact. The test contact record
     */
    public static Contact createTestContact(String firstName, String lastName, Boolean doInsert) {
        Account testAccount = createTestAccount('Test Account', true);

        return createTestContact(firstName, lastName, testAccount.Id, doInsert);
    }

    /**
     * Create N test contacts linked to the same test account
     * @param   Integer. Number of test contacts to create
     * @param   Boolean. Whether or not to insert the test contacts
     * @return  List<Contact>. The list of test contacts
     */
    public static List<Contact> createNTestContactsWithSameAccount(Integer numberToCreate, Boolean doInsert) {
        List<Contact> testContacts = new List<Contact>();
        Account testAccount = createTestAccount('Test Account', true);

        for (Integer contactCount = 0; contactCount < numberToCreate; contactCount++) {
            String firstName = 'Inigo';
            String lastName  = 'Montoya #' + String.valueOf(contactCount + 1);

            testContacts.add(createTestContact(firstName, lastName, testAccount.Id, false));
        }

        if (doInsert) {
            insert testContacts;
        }

        return testContacts;
    }

    /**
     * Create N test contacts linked to the same test account
     * @param   Integer. Number of test contacts to create
     * @param   Id. Id of the account to link to all the test contacts
     * @param   Boolean. Whether or not to insert the test contacts
     * @return  List<Contact>. The list of test contacts
     */
    public static List<Contact> createNTestContactsWithSameAccount(Integer numberToCreate, Id accountId, Boolean doInsert) {
        List<Contact> testContacts = new List<Contact>();

        for (Integer contactCount = 0; contactCount < numberToCreate; contactCount++) {
            String firstName = 'Inigo';
            String lastName  = 'Montoya #' + String.valueOf(contactCount + 1);

            testContacts.add(createTestContact(firstName, lastName, accountId, false));
        }

        if (doInsert) {
            insert testContacts;
        }

        return testContacts;
    }

    /**
     * Create N test contacts, each linked to a different test account
     * @param   Integer. Number of test accounts and contacts to create
     * @param   Boolean. Whether or not to insert the test contacts
     * @return  List<Contact>. The list of test contacts
     */
    public static List<Contact> createNTestContactsWithDiffAccounts(Integer numberToCreate, Boolean doInsert) {
        List<Contact> testContacts = new List<Contact>();
        List<Account> testAccounts = createNTestAccounts(numberToCreate, true);
        Integer cCount = 1;

        for (Account testAccount : testAccounts) {
            String firstName = 'Inigo';
            String lastName  = 'Montoya' + String.valueOf(cCount);
            cCount++;

            testContacts.add(createTestContact(firstName, lastName, testAccount.Id, false));
        }

        if (doInsert) {
            insert testContacts;
        }

        return testContacts;
    }

    /**
     * Create N test contacts, each linked to a different test account
     * @param   List<Id>. A list of account Ids to link contacts to
     * @param   Boolean. Whether or not to insert the test contacts
     * @return  List<Contact>. The list of test contacts
     */
    public static List<Contact> createNTestContactsWithDiffAccounts(List<Id> accountIds, Boolean doInsert) {
        List<Contact> testContacts = new List<Contact>();
        Integer cCount = 1;

        for (Id accId : accountIds) {
            String firstName = 'Inigo';
            String lastName  = 'Montoya' + String.valueOf(cCount);
            cCount++;

            testContacts.add(createTestContact(firstName, lastName, accId, false));
        }

        if (doInsert) {
            insert testContacts;
        }

        return testContacts;
    }

    /* **************************************************  */
    /*                    Desire__c                        */
    /* **************************************************  */

    /**
     * Creates a Desire__c record for testing
     * @param   String. Name of the desire, stored in the field: 'Thing__c'
     * @param   Id. Id of the user who will be the owner of the record. Can be set to null
     * @param   Boolean. Whether or not to insert the test record
     * @return  Desire__c. The test Desire__c record
     */
    public static Desire__c createTestDesire(String nameOfDesire, Id ownerId, Boolean isPurchased, Boolean doInsert) {
        Desire__c testDesire = new Desire__c();

        if (ownerId != null) {
            testDesire.OwnerId = ownerId;
        }

        testDesire.Thing__c = nameOfDesire;
        testDesire.Reason__c = 'Lorem Ipsum';
        testDesire.Status__c = 'Wanted';
        testDesire.Research_Notes__c = '';
        testDesire.Type__c = 'Game';    //  Pick random
        testDesire.Platform__c = 'PC - Steam';  //  Pick random if Type__c = 'Game'
        
        Date asOfDate = Date.newInstance(2020, 12, 01);
        testDesire.As_Of_Date__c = asOfDate;
        testDesire.As_Of_Price__c = 100.00;
        testDesire.As_Of_Store__c = 'Just another brick in the store';
        testDesire.As_Of_URL__c = '';

        if (isPurchased) {
            Integer purchasedDaysAfter = 5;
            Date purchaseDate = asOfDate.addDays(purchasedDaysAfter);
            Decimal percentageOfAsOfPrice = 1.00;

            testDesire.Purchased_Date__c  = purchaseDate;
            testDesire.Purchased_Price__c = percentageOfAsOfPrice;
            testDesire.Purchased_Store__c = testDesire.As_Of_Store__c;
            testDesire.Purchased_Notes__c = 'I don\'t know if I got a good deal or not.';
        }

        if (doInsert) {
            insert testDesire;
        }

        return testDesire;
    }

    /**
     * Creates N amount of Desire__c records for testing and assign them all to the same user
     * @param   Integer. The number of test Desire__c records to create
     * @param   Id. The Id of the user to assign as the owner to all test records
     * @param   Boolean. Whether or not to insert the test records
     * @return  List<Desire__c>. List of test Desire__c records
     */
    public static List<Desire__c> createNTestDesires(Integer numberToCreate, Id ownerId, Boolean doInsert) {
        List<Desire__c> testDesires = new List<Desire__c>();

        for (Integer dCount = 0; dCount < numberToCreate; dCount++) {
            String desireThingName = 'Test Thing #' + String.valueOf(dCount + 1);
            Boolean isPurchased = (Math.random() > 0.5);

            testDesires.add(createTestDesire(desireThingName, ownerId, isPurchased, false));
        }

        if (doInsert) {
            insert testDesires;
        }

        return testDesires;
    }

}