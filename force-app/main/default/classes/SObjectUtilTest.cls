/**
 * @class:   SObjectUtilTest.cls
 * @author:  Jason Auger
 * @desc:    Test class for SObjectUtil.cls
 * @licence: 
 */
@isTest
private class SObjectUtilTest {
    private static Set<String> PREFERRED_SOBJECTS = new Set<String>{'Account', 'Contact', 'Case', 'Lead', 'Opportunity', 'Order', 'Product2', 'Quote'};

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
    static void testGetSetOfOrgSObjects() {
        //  Populate the set
        Set<String> orgSObjects = SObjectUtil.getSetOfOrgSObjects();

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
        String sObjectAPINameToTest = null;
        Set<String> retrievedSObjs = SObjectUtil.getSetOfOrgSObjects();
        for (String sObj : PREFERRED_SOBJECTS) {
            if (retrievedSObjs.contains(sObj)) {
                sObjectAPINameToTest = sObj;
                break;
            }
        }
        System.assertNotEquals(null, sObjectAPINameToTest);

        Boolean resultOfPassTest = null;
        String exceptionPass = '';
        try {
            SObjectUtil utilTestPass = new SObjectUtil(sObjectAPINameToTest);
            resultOfPassTest = true;
        } catch (Exception e) {
            resultOfPassTest = false;
            exceptionPass = e.getMessage();
        }
        System.assertEquals(true, resultOfPassTest, 'Could not create SObjectUtil class for SObject: ' + sObjectAPINameToTest + '. Error: ' + exceptionPass);

        String sObjFail = sObjectAPINameToTest + '__Fail';
        Boolean resultOfFailTest = null;
        try {
            SObjectUtil utilTestFail = new SObjectUtil(sObjFail);
            resultOfFailTest = true;
        } catch (Exception e) {
            resultOfFailTest = false;
        }
        System.assertEquals(false, resultOfFailTest, 'The SObjectUtil class was successfully created for: ' + sObjFail + ' when it should have failed.');
    }

    /**
     * Tests that the record type map is appropriately set to null when no record types are set
     * for a given SObject in the org
     */
    @isTest
    static void testPopulateMapRecordTypesZero() {
        String sObjectAPINameToTest = null;
        Set<String> sObjectsWithRts = getSObjectsWithRecordTypes();
        Set<String> retrievedSObjs = SObjectUtil.getSetOfOrgSObjects();

        //  All SObjects in the sObjectsWithRts should be in retrievedSObjs
        for (String sObjToRemove : sObjectsWithRts) {
            if (retrievedSObjs.contains(sObjToRemove)) {
                retrievedSObjs.remove(sObjToRemove);
            }
        }

        //  Get random SObject
        Integer randomSObjectNumber = Integer.valueOf(Math.random() * (retrievedSObjs.size() - 1));
        Integer indexCount = 0;
        for (String sObjectName : retrievedSObjs) {
            if (indexCount == randomSObjectNumber) {
                sObjectAPINameToTest = sObjectName;
            }
            indexCount++;
        }

        //  Do the asserts

    }

    /**
     * Tests that the record type map is appropriately populated when an SObject has more than
     * one record type
     */
    @isTest
    static void testPopulateMapRecordTypesMultiple() {
        String sObjectAPINameToTest = null;
        Set<String> sObjectsWithRts = getSObjectsWithRecordTypes();

        if (!sObjectsWithRts.isEmpty()) {

            Integer randomSObjectNumber = Integer.valueOf(Math.random() * (sObjectsWithRts.size() - 1));
            Integer indexCount = 0;
            for (String sObjectName : sObjectsWithRts) {
                if (indexCount == randomSObjectNumber) {
                    sObjectAPINameToTest = sObjectName;
                }
                indexCount++;
            }

            for (String sObj : PREFERRED_SOBJECTS) {
                if (sObjectsWithRts.contains(sObj)) {
                    sObjectAPINameToTest = sObj;
                    break;
                }
            }
            System.assertNotEquals(null, sObjectAPINameToTest);
    
            //  Do the asserts
            SObject sObjUtil = new SObjUtil(sObjectAPINameToTest);
        } else {
            //  Can't really be tested if no objects have Record Types set up
        }
    }

    /**
     * Tests to see that the select all string generated by the util contains all the same fields
     * as manually queried from the org
     */
    @isTest
    static void testSelectAllString() {
        String sObjectAPINameToTest = null;
        Set<String> sObjectsWithRts = getSObjectsWithRecordTypes();
        for (String sObj : PREFERRED_SOBJECTS) {
            if (sObjectsWithRts.contains(sObj)) {
                sObjectAPINameToTest = sObj;
                break;
            }
        }
        System.assertNotEquals(null, sObjectAPINameToTest, 'No SObject to test.'); //  Make sure there is an object to test

        SObjectUtil sObjToTest = new SObjectUtil(sObjectAPINameToTest);
        System.assertNotEquals(null, sObjToTest);   //  Make sure the new object is not a null value

        List<String> sObjFieldList = new List<String>();
        sObjFieldList = sObjToTest.selectAllString.split(', ');
        SObject sObjInstance = Schema.getGlobalDescribe().get(sObjectAPINameToTest).newSObject() ;

        Integer countSuccess = 0;
        Integer countFail = 0;
        for (String field : sObjFieldList) {
            try {
                sObjInstance.get(field);
                countSuccess += 1;
            } catch (Exception e) {
                countFail += 1;
            }
        }

        System.assertEquals(0, countFail);  //  Make sure there are no field mismatches
        System.assertEquals(sObjFieldList.size(), countSuccess);    //  Make sure the success count is the same as the list size

        //  Make a query to check it does not fail
        List<SObject> queryResults = null;
        String queryTestString = '';
        Boolean querySuccess = null;
        String queryErrorString = '';
        try {
            queryTestString += 'SELECT ' + sObjToTest.selectAllString + ' ';
            queryTestString += 'FROM ' + sObjectAPINameToTest + ' ';
            queryResults = Database.query(queryTestString);
            querySuccess = true;
        } catch (Exception e) {
            querySuccess = false;
            queryErrorString = e.getMessage();
        }
        System.assert(querySuccess, 'The query was unsuccessful. ' + queryErrorString); //  Test the query worked correctly with all fields
    }

    /**
     * Queries and returns a Set of Strings, which are SObject API Names
     */
    private static Set<String> getSObjectsWithRecordTypes() {
        List<AggregateResult> rtAggRes = [
            SELECT SObjectType
            FROM RecordType
            GROUP BY SObjectType
        ];
        Set<String> sObjectsWithRts = new Set<String>();
        for (AggregateResult ar : rtAggRes) {
            sObjectsWithRts.add(String.valueOf(ar.get('SObjectType')));
        }
        return sObjectsWithRts;
    }
}
