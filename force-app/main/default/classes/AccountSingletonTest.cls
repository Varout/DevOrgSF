/**
 * Class: AccountSingletonTest.cls
 * Tests: AccountSingleton.cls
 * @desc: Unit test class for the AccountSingleton class. Expands on
 *        the SingletonObject.cls class and its functionality.
 */
@isTest
private class AccountSingletonTest {

    /**
     * Check that our get functions work and known values exist in the right places
     */
    @isTest
    static void createInstance() {
        AccountSingleton newAccSngtn = AccountSingleton.getInstance();
        System.assertNotEquals(null, newAccSngtn);
        System.assertNotEquals(null, newAccSngtn.randomTestNumber);

        //  We know that Account has the following fields at a minimum:
        //  Note: These are case sensitive
        Set<String> ENUM_DATES        = new Set<String>{'SLAExpirationDate__c'};
        Set<String> ENUM_DECIMAL      = new Set<String>{'NumberofLocations__c', 'NumberOfEmployees'};
        Set<String> ENUM_PICKLISTVALS = new Set<String>{'Bronze', 'Silver', 'Gold', 'Platinum'};    //  Picklist values for SLA__c
        Set<String> ENUM_STRINGS      = new Set<String>{'Name', 'SLASerialNumber__c'};

        Map<String, String> fieldNameEnumType = newAccSngtn.getMapFieldNameType();
        Set<String> picklistValsSla = new Set<String>();
        for (Schema.PicklistEntry ple : newAccSngtn.getPicklistsAndValues().get('SLA__c')) {
            picklistValsSla.add(ple.getLabel());
        }

        //  Asserts to make sure we have some known correct data in our sets/lists/maps
        for (String enumVal : ENUM_DATES) {
            System.assert(fieldNameEnumType.keySet().contains(enumVal));
        }
        for (String enumVal : ENUM_DECIMAL) {
            System.assert(fieldNameEnumType.keySet().contains(enumVal));
        }
        for (String enumVal : ENUM_STRINGS) {
            System.assert(fieldNameEnumType.keySet().contains(enumVal), enumVal);
        }
        for (String picklistVal : ENUM_PICKLISTVALS) {
            System.assert(picklistValsSla.contains(picklistVal), picklistVal);
        }
    }

    /**
     * Check to make sure the Singleton pattern is working as expected, using a
     * random number generator
     */
    @isTest
    static void checkMultipleGetInstances() {
        //  Initialise the singleton in a new var and check the random number has been assigned
        AccountSingleton singletonAcc = AccountSingleton.getInstance();
        System.assertNotEquals(null, singletonAcc);

        Integer initRandomNumber = null;
        initRandomNumber = singletonAcc.randomTestNumber;

        //  We expect the random number to not be null, and between 0 and 1000 inclusive
        System.assertNotEquals(null, singletonAcc.randomTestNumber);
        System.assertNotEquals(null, initRandomNumber);
        System.assert(initRandomNumber >= 0);
        System.assert(initRandomNumber <= 1000);

        AccountSingleton singletonNew = AccountSingleton.getInstance();
        System.assertNotEquals(null, singletonNew);

        Integer nextRandomNumber = null;
        nextRandomNumber = singletonNew.randomTestNumber;

        System.assertNotEquals(null, singletonNew.randomTestNumber);
        System.assertEquals(initRandomNumber, singletonNew.randomTestNumber);
        System.assertEquals(nextRandomNumber, singletonNew.randomTestNumber);
        System.assertEquals(initRandomNumber, nextRandomNumber);
    }

    /**
     * 
     */
    @isTest
    static void testGetRecordTypes() {
        AccountSingleton singletonAcc = AccountSingleton.getInstance();
        System.assertNotEquals(null, singletonAcc);

        List<RecordType> accountRecordTypesQueried = getAccountRecordTypes();
        Map<String, RecordType> accountRecordTypesSingleTon = singletonAcc.getRecordTypes();

        System.assertEquals(accountRecordTypesQueried.size(), accountRecordTypesSingleTon.values().size());
        for (RecordType rt : accountRecordTypesQueried) {
            Id singletonRtId = accountRecordTypesSingleTon.get(rt.Name).Id;
            String singletonRtName = accountRecordTypesSingleTon.get(rt.Name).Name;
            System.assertEquals(rt.Id, singletonRtId);
            System.assertEquals(rt.Name, singletonRtName);
        }
    }

    /**
     * 
     */
    @isTest
    static void testGetAccountRecordTypeIdFromName() {
        AccountSingleton singletonAcc = AccountSingleton.getInstance();
        System.assertNotEquals(null, singletonAcc);

        List<RecordType> accountRecordTypesQueried = getAccountRecordTypes();
        for (RecordType rt : accountRecordTypesQueried) {
            System.assertEquals(rt.Id, singletonAcc.getRecordTypeIdFromName(rt.Name));
        }
    }

    /**
     * Uses a SOQL query to get all Account Record Types, their Ids and Names
     */
    private static List<RecordType> getAccountRecordTypes() {
        return [
            SELECT Id, Name
            FROM RecordType
            WHERE SObjectType = 'Account'
        ];
    }
}
