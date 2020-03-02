/**
 * The idea of this is to enable getting a lot of needed information
 * from any SObject (standard or custom) using a single util class
 */
public with sharing class SObjectUtil {
    public SObjectUtil() {

    }

    //  Get all fields and types
    //  SOQL selector function
    //  Get all picklists and their options
    //  Get a list of all SObjects (standard / custom)
    //  Does the org use person accounts
    //  Get list of record types for SObjects
    //  Get Map of fields with default values, and what the value is

    /*
        Useful links
        https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_fields_describe.htm#apex_methods_system_fields_describe
        https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_SObjectField.htm
        https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_RecordTypeInfo.htm
        https://medium.com/@sfdcbrewery/apex-design-patterns-sfdc-brewery-salesforce-developer-interview-preparation-series-2c5296a9ed0f
        https://www.jitendrazaa.com/blog/apex-design-patterns/
        https://www.mstsolutions.com/technical/apex-design-patterns/
    */

    /**
     * Gets the developer name for all stanard and custom objects
     * in the current Salesforce org
     * @return  Set<String>. 
     */
    public static Set<String> getListOfSObjects() {
        Set<String> sObjects = new Set<String>();
        for (Schema.SObjectType sObjType : Schema.getGlobalDescribe().values()) {
            sObjects.add(String.valueOf(sObjType));
        }
        return sObjects;
    }

    /**
     * 
     */
    public static Map<String, String> getListOfFieldsTypesForSObject(String sObjectName) {
        return null;
    }

    /**
     * Returns all fields for a given SObject
     * @param   String. Name of the SObject
     * @return  Set<String>. A set of all field names for the sObject
     */
    public static Set<String> getListOfFieldsForSObject(String sObjectName) {
        return getListOfFieldsTypesForSObject(sObjectName).keySet();
    }

}
