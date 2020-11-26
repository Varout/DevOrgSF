/**
 * Class: TestObjectFactory
 * @desc: Contains methods to create test data.  All methods should be static.
 */
public class TestObjectFactory {

    //  Note to self: Could be worth changing SObjectUtil class to use a Singleton method
    // final private static SObjectUtil OBJ_UTIL_ACCOUNT = new SObjectUtil('Account');
    // final private static SObjectUtil OBJ_UTIL_CONTACT = new SObjectUtil('Contact');

    /* **************************************************  */
    /*                    General                          */
    /* **************************************************  */

    /**
     * Get total number of existing records of given SObject Type
     * @param   String. Type of SObject to query
     * @return  Integer. Number of records for the given SObject Type
     */
    public static Integer getSObjectRecordCount(String SObjectType) {
        String baseQuery = 'SELECT Id FROM ';
        return (Database.query(baseQuery + SObjectType)).size();
    }


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

    /**
     * IDEA:
     * Create a test method that accepts a string of SObject names
     * Check that all objects exist in the org
     * Use SObjectUtil to create objects with bare minimum insert criteria i.e. All required fields on the SObject side populated
     *
     * Would this be worth the extra DML?
     * 1 to check the SObjectType
     * 3 per SObject
     *   -) 2 per creation of the SObjectUtil
     *   -) 1 to insert per SObject
     */
}