/**
 * @class:  SObjectUtil.cls
 * @test:   SObjectUtilTest.cls
 * @author: Jason (Trineo Ltd)
 * @desc:   
 * 
 * @Extra Notes: The idea of this is to enable getting a lot of needed information
 * from any SObject (standard or custom) using a single util class
 */
public with sharing class SObjectUtil {

    final private Set<String> ENUM_PICKLIST = new Set<String>{'PICKLIST', 'MULTIPICKLIST'};
    final public Set<String> ENUM_FIELD_TYPES = new Set<String>{
        'address', 'anytype', 'base64', 'Boolean', 'Combobox', 'Currency',
        'DataCategoryGroupReference', 'Date', 'DateTime', 'Double', 'Email',
        'EncryptedString', 'ID', 'Integer', 'Long', 'MultiPicklist', 'Percent',
        'Phone', 'Picklist', 'Reference', 'String', 'TextArea', 'Time', 'URL'
    };  //  https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_enum_Schema_DisplayType.htm

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
     * @param   String. Name of the SObject to query
     * @return  Map<String, String>. Map of DeveloperName > Type for each field on the SObject
     */
    public static Map<String, String> getListOfFieldsTypesForSObject(String sObjectDevName) {
        Map<String, String> mapFieldNameType = new Map<String, String>();
        SObjectType sobjectDescribe = Schema.getGlobalDescribe().get(sObjectDevName);
        Map<String, Schema.SObjectField> mapAccFields = sobjectDescribe.getDescribe().fields.getMap();

        for (String fieldKey : mapAccFields.keySet()) {
            String fieldName = mapAccFields.get(fieldKey).getDescribe().getName();
            String fieldType = String.valueOf(mapAccFields.get(fieldKey).getDescribe().getType());
            mapFieldNameType.put(fieldName, fieldType);
        }
        
        return mapFieldNameType;
    }

    /**
     * Returns all fields for a given SObject
     * @param   String. Name of the SObject
     * @return  Set<String>. A set of all field names for the sObject
     */
    public static Set<String> getListOfFieldsForSObject(String sObjectName) {
        return getListOfFieldsTypesForSObject(sObjectName).keySet();
    }

    /**
     * 
     * @param   String. Developer name of the SObject to query
     * @param   Boolean. If true, returns only active record types
     *                   If false, returns all record types. Active or not
     * @return  Map<String, Id>. 
     */
    public static Map<String, Id> getListOfRecordTypesForSObject(String sObjectDevName, Boolean activeOnly) {
        String queryString = '';
        queryString += 'SELECT Id, DeveloperName ';
        queryString += 'FROM RecordType ';
        queryString += 'WHERE SObjectType = ' + sObjectDevName + ' ';
        if (activeOnly) {
            queryString += 'AND IsActive = true';
        }

        Map<String, Id> returnMap = new Map<String, Id>();
        for (RecordType rt : Database.query(queryString)) {
            returnMap.put(rt.DeveloperName, rt.Id);
        }

        return returnMap;
    }

}
