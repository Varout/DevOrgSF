/**
 * @class:   SObjectUtilTest.cls
 * @author:  Jason Auger
 * @desc:    Test class for SObjectUtil.cls
 * @licence: 
 */
@isTest
private class SObjectUtilTest {
    /**
     * Check to see if the org uses Person Accounts by using two different methods
     * and then check against what the util class returns
     */
    @isTest
    static void testOrgUsesPersonAccounts() {
        Boolean paCheckMethodOne = null;
        try {
            SObject testObject = new Account();
            testObject.get('isPersonAccount');
            // If we got here without an exception, set to true.
            paCheckMethodOne = true;
        } catch(Exception ee) {
            // An exception was generated trying to access the isPersonAccount field
            // so person accounts aren't enabled; set to false.
            paCheckMethodOne = false;
        }

        Boolean paCheckMethodTwo = Schema.sObjectType.Account.fields.getMap().containsKey('isPersonAccount');

        Boolean paCheckUtilClass = SObjectUtil.orgUsesPersonAccounts();

        System.assertEquals(paCheckUtilClass, paCheckMethodOne);
        System.assertEquals(paCheckUtilClass, paCheckMethodTwo);
    }

    /**
     * Tests getting all SObjects in an org from the static function
     */
    @isTest
    static void testGetListOfOrgSObjects() {
        //  Populate the set
        Set<String> orgSObjects = SObjectUtil.getListOfOrgSObjects();

        //  We know there are standard objects, so the set should have at least one entry
        System.assert(orgSObjects.size() > 0);
        //  We also know there are a list of standard Salesforce objects which can be checked
        //  to see if they are in the set, but in the unlikely event they change, they won't
        //  be checked here
    }

    /**
     * Tests to see that we can successfully create a util instance for a valid SObject,
     * and that an error is thrown when trying to create a util instance for an invalid object
     */
    @isTest
    static void testConstructorSuccessAndFail() {

    }

    /**
     * 
     */
    static void testPopulateMapRecordTypesZero() {

    }

    /**
     * 
     */
    static void testPopulateMapRecordTypesMultiple() {

    }

    /**
     * 
     */
    static void testSelectAllString() {

    }
}
