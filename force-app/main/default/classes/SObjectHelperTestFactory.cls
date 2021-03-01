/**
 * @class:   SObjectHelperTestFactory.cls
 * @test:    SObjectHelperTestFactoryTest.cls
 * @author:  Jason Auger
 * @github:  https://github.com/Varout/...
 * @desc:
 * @licence: Copyright (c) 2020, Jason Auger
 *           Permission is hereby granted, free of charge, to any person obtaining a copy
 *           of this software and associated documentation files (the "Software"), to deal
 *           in the Software without restriction, including without limitation the rights
 *           to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *           copies of the Software, and to permit persons to whom the Software is
 *           furnished to do so, subject to the following conditions:
 *
 *           The above copyright notice and this permission notice shall be included in all
 *           copies or substantial portions of the Software.
 *
 *           THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *           IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *           FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *           AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *           LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *           OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *           SOFTWARE.
 */
public with sharing class SObjectHelperTestFactory {

    public class SObjectHelperTestFactoryException extends Exception {}

    //  The suffix for the classes that handle your trigger code. e.g. 'AccountTriggerHandler', 'ContactTriggerHandler'
    //  This will be used to bypass triggers if using the O'Hara trigger pattern
    public static String TRIGGER_PATTERN = 'TriggerHandler';

    private static Boolean BYPASS_TRIGGERS = false;

    private SObjectHelperTestFactory() {}

    /* ************************************************ */
    /*           Main Public Static Functions           */
    /* ************************************************ */

    /**
     *
     * @param   String. The name of the SObject
     * @return  SObject. The type of SObject defined in the passed string
     */
    public static SObject createTestData(String sObjectName) {
        return null;
    }


    // /**
    //  *
    //  * @param   Set<String>. A set of Strings with different SObject names
    //  * @return  List<SObject>. A list of SObjects, one of each type passed in the set of strings
    //  * @thoughts: Maybe change return to something like Map<String, List<SObject>> where the string is the name of the sobject
    //  */
    // public static List<SObject> createTestData(Set<String> setSObjectNames) {
    //     return null;
    // }


    /**
     *
     * @param   Map<String, Integer>. Key/value pair of strings which are the names of the SObjects to create
     *          alongside the value (integer) for the number of those SObject records to create
     * @return  List<SObject>. A list of SObjects that have been created to be inserted
     * @thoughts: As above maybe change return to something like Map<String, List<SObject>> where the string is the name of the sobject
     */
    public static List<SObject> createTestData(Map<String, Integer> mapSObjectNamesCount) {
        return null;
    }



    /* ************************************************ */
    /* Public Static Functions With Additional Boolean  */
    /* These are double-ups of existing functions with  */
    /* an additional Boolean parameter which allows the */
    /* programmer to specify whether or not they want   */
    /* the data to be inserted before it is returned.   */
    /* ************************************************ */

    /**
     *
     */
    public static SObject createTestData(String sObjectName, Boolean doInsert) {
        SObject returnData = createTestData(sObjectName);
        if (doInsert) { insert returnData; }
        return returnData;
    }

    // /**
    //  *
    //  */
    // public static List<SObject> createTestData(Set<String> setSObjectNames, Boolean doInsert) {
    //     List<SObject> returnData = createTestData(setSObjectNames);
    //     if (doInsert) { insert returnData; }
    //     return returnData;
    // }


    /**
     *
     */
    public static List<SObject> createTestData(Map<String, Integer> mapSObjectNamesCount, Boolean doInsert) {
        List<SObject> returnData = createTestData(mapSObjectNamesCount);
        if (doInsert) { insert returnData; }
        return returnData;
    }


    /* ************************************************ */
    /*                 Private Functions                */
    /* ************************************************ */


    /**
     * Returns a random String of alphanumeric characters of length 50
     * @return  String. The randomly generated string
     */
    @TestVisible
    private static String createRandomString() {
        return createRandomString(50);
    }


    /**
     * Returns a random String of alphanumeric characters of a defined length
     * @param   Integer. The length of the string to be created. Must be a positive value
     * @return  String. The randomly generated string
     */
    @TestVisible
    private static String createRandomString(Integer stringLength) {
        return '';
    }


    /**
     * Creates a random Integer of length 10
     * @return  Integer. The randomly generated integer
     */
    @TestVisible
    private static Integer createRandomInteger() {
        return createRandomInteger(10);
    }


    /**
     * Creates a random Integer of a defined length
     * @param   Integer. The length of the integer to create. Cannot be longer than length 16. Must be a positive value
     * @return  Integer. The randomly generated integer
     */
    @TestVisible
    private static Integer createRandomInteger(Integer length) {
        return null;
    }


    /**
     * Creates a random Decimal with a length of 8 for the whole number portion and 2 decimal places
     * @return  Decimal. The randomly generated decimal
     */
    @TestVisible
    private static Decimal createRandomDecimal() {
        return createRandomDecimal(8, 2);
    }


    /**
     * Creates a random Decimal of a defined length. The whole number portion and decimal places portion lengths
     * cannot add up to a number larger than 16. If a length larger than 16 is passed, the value will default
     * to be equivalent to createRandomDecimal(16, 0). Must be a positive value
     * @return  Decimal. The randomly generated decimal
     */
    @TestVisible
    private static Decimal createRandomDecimal(Integer wholeNumber, Integer partNumber) {
        //  https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_decimal.htm#apex_methods_system_decimal
        return null;
    }


    /**
     * Given a picklist, select a random value from it
     * @param   List<String>. A list of strings which contains the options for the picklist
     * @return  String. The random value to be used
     */
    @TestVisible
    private static String selectRandomPicklistValue(List<String> listAvailablePicklistValues) {
        Integer randomIndexInt = Integer.valueOf(Math.floor(Math.random() * listAvailablePicklistValues.size()));
        return listAvailablePicklistValues[randomIndexInt];
    }


    /**
     * Returns a random Boolean value
     */
    @TestVisible
    private static Boolean returnRandomBoolean() {
        if (Math.mod(Math.round( Math.random() * 10), 2) == 1)  {
            return true;
        } else {
            return false;
        }
    }



    /* ************************************************ */
    /*     O'Hara Trigger Pattern Related Functions     */
    /*                                                  */
    /* The following functions come as commented out by */
    /* default, along with their test functions in the  */
    /* unit test class. If you are using the O'Hara     */
    /* SFDC Trigger Pattern, you can use this code for  */
    /* extra functionality.                             */
    /* ************************************************ */

    // /**
    //  *
    //  */
    // public static void bypassTriggers() {
    //     SObjectHelperTestFactory.BYPASS_TRIGGERS = true;
    // }


    // /**
    //  *
    //  */
    // public static void bypassTriggersClear() {
    //     SObjectHelperTestFactory.BYPASS_TRIGGERS = false;
    //     TriggerHandler.clearAllBypasses();
    // }


    // private static void bypassTriggersForSObjects(Set<String> setSObjectsToBypass) {
    //     for (String sObjName : setSObjectsToBypass) {
    //         TriggerHandler.bypass(sObjName + SObjectHelperTestFactory.TRIGGER_PATTERN);
    //     }
    // }
}