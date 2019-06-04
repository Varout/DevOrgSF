/**
 * Class Name: TestObjectFactory
 * Created: March 2019
 * Edited:  March 2019
 * Authors: Jason Auger
 * Description: Contains methods to create test data.  All methods should be static.
 */
public with sharing class TestObjectFactory {
    public TestObjectFactory() {}

    /**
     * @name: getFitbitMonths
     * @date: March 2019
     * @author: Jason Auger
     * @input:
     *      - 1)    Type: Boolean.  If true, inserts the test data into Salesforce.
     * @description: Creates and returns a List<Fitbit_Month__c> for testing purposes using
     *               the current month and all days in the month.
     */
    public static Fitbit_Month__c getFitbitMonths(Boolean shouldInsert) {
        Fitbit_Month__c fitbitMonth;

        if (shouldInsert) {
            insert fitbitMonth;
            getFitbitDays(Date.today(), true);
        }

        return fitbitMonth;
    }

    /**
     * @name: getFitbitDays
     * @date: March 2019
     * @author: Jason Auger
     * @input:
     *      - 1)    Type: Date.  A date which resides in the month to create Fitbit_Day__c
     *              instances for.  Example: If 2019-02-?? is passed, it will create data for February 2019.
     *      - 2)    Type: Boolean.  If true, inserts the test data into Salesforce.
     * @description: Creates and returns a List<Fitbit_Day__c> for testing purposes.  Used by
     *               the function: getFitbitMonths to populate the days of the month.
     */
    public static List<Fitbit_Day__c> getFitbitDays(Date fitbitMonths, Boolean shouldInsert) {
        List<Fitbit_Day__c> fitbitDays = new List<Fitbit_Day__c>();
        return fitbitDays;
    }
}