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


 * If is picklist: getPicklistValues() - List<Schema.PicklistEntry> ple;
 * If is integer: getDigits() - Max length
 * If is double: getPrecision() - Max length
 * If is double: getScale() - Number of digits to the right of decimal point

//  Link: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_fields_describe.htm#apex_methods_system_fields_describe
SObjectType accountType = Schema.getGlobalDescribe().get('Account');
Map<String, Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap();
for (String s : mfields.keySet()) {
    System.debug(mfields.get(s).getDescribe().getName());
    System.debug(mfields.get(s).getDescribe().getLabel());
    System.debug(mfields.get(s).getDescribe().getType());
    System.debug(mfields.get(s).getDescribe().getPicklistValues());
}


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
