/**
 * @class:   SObjectUtil.cls
 * @test:    SObjectUtilTest.cls
 * @author:  Jason Auger
 * @desc:    
 * @licence: 
 */
public with sharing class SObjectUtil {
    public class SObjectUtilException extends Exception{}

    final private Set<String> ENUM_PICKLISTS = new Set<String>{'PICKLIST', 'MULTIPICKLIST'};
    //  Salesforce ENUM information: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_enum_Schema_DisplayType.htm
    final private Set<String> ENUM_FIELD_TYPES = new Set<String>{
        'ADDRESS', 'ANYTYPE', 'BASE64', 'BOOLEAN', 'COMBOBOX', 'CURRENCY',
        'DATACATEGORYGROUPREFERENCE', 'DATE', 'DATETIME', 'DOUBLE', 'EMAIL',
        'ENCRYPTEDSTRING', 'ID', 'INTEGER', 'LONG', 'MULTIPICKLIST', 'PERCENT',
        'PHONE', 'PICKLIST', 'REFERENCE', 'STRING', 'TEXTAREA', 'TIME', 'URL'
    };

    private SObjectType theSObjectDescribe { get; private set; }

    public String selectAllString { get; private set; }
    public Map<String, Id>     mapRecordTypeNameToId { get; private set; }
    public Map<String, String> mapDevNameToType { get; private set; }
    //  Schema.PicklistEntry function information: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_PicklistEntry.htm#apex_class_Schema_PicklistEntry
    public Map<String, List<Schema.PicklistEntry>> mapPicklistValues { get; private set; }

    public SObjectUtil(String sObjectType) {
        try {
            this.theSObjectDescribe = Schema.getGlobalDescribe().get(sObjectType);
        } catch (Exception e) {
            throw new SObjectUtilException('An error occurred.', e);
        }
        if (this.theSObjectDescribe == null) {
            throw new SObjectUtilException('The SObject: "' + sObjectType + '" does not exist in this org.');
        }

        try {
            this.populateMapFieldInformation(sObjectType);
            this.populateMapRecordTypes(sObjectType);
        } catch (Exception e) {
            throw new SOBjectUtilException('An error occurred: ' + e.getMessage());
        }
    }

    /*  ****************************************  */
    /*             Private Functions              */
    /*  ****************************************  */

    /**
     * Populates the public variable in the class: mapDevNameToType
     * @param   String. API Name of the SObject to populate field
     *          name and type inforation for.
     */
    private void populateMapFieldInformation(String theSObjectType) {
        this.mapDevNameToType = new Map<String, String>();
        this.mapPicklistValues = new Map<String, List<Schema.PicklistEntry>>();
        Map<String, Schema.SObjectField> mapAccFields = this.theSObjectDescribe.getDescribe().fields.getMap();

        for (String fieldKey : mapAccFields.keySet()) {
            //  Populdate map of FieldName to FieldType
            String fieldName = mapAccFields.get(fieldKey).getDescribe().getName();
            String fieldType = String.valueOf(mapAccFields.get(fieldKey).getDescribe().getType());
            this.mapDevNameToType.put(fieldName, fieldType);

            //  Populate map of FieldName to PicklistValues for any picklist field type
            if (this.ENUM_PICKLISTS.contains(fieldType.toUpperCase())) {
                this.mapPicklistValues.put(fieldName, mapAccFields.get(fieldKey).getDescribe().getPicklistValues());
            }
        }

        //  Populate select all string used for a wildcard SOQL selector query
        this.selectAllString = String.join(new List<String>(this.mapDevNameToType.keySet()), ', ');
    }

    /**
     * Populates the public variable in the class: mapRecordTypeNameToId
     * @param   String. API Name of the SObject to populate Record Type
     *          information for.
     */
    private void populateMapRecordTypes(String theSObjectType) {
        this.mapRecordTypeNameToId = new Map<String, Id>();

        for (RecordType rt : this.queryRecordTypes(theSObjectType)) {
            this.mapRecordTypeNameToId.put(rt.Name, rt.Id);
        }
    }

    /**
     * Uses a SOQL query to get all record types for the given sobject
     * @return  List<RecordType>
     */
    private List<RecordType> queryRecordTypes(String theSObjectType) {
        return [
            SELECT Id, Name, DeveloperName, IsActive, SObjectType, Description
            FROM RecordType
            WHERE SObjectType = :theSObjectType
        ];
    }

    /*  ****************************************  */
    /*          Public Static Functions           */
    /*  ****************************************  */

    /**
     * Gets the developer name for all standard and custom objects
     * in the current Salesforce org
     * @return  Set<String>.
     */
    public static Set<String> getSetOfOrgSObjects() {
        Set<String> sObjects = new Set<String>();
        for (Schema.SObjectType sObjType : Schema.getGlobalDescribe().values()) {
            sObjects.add(String.valueOf(sObjType));
        }
        return sObjects;
    }

    /**
     * Checks to see if Person Accounts are enabled in the current org
     * @return  Boolean. Returns true if the current org uses Person Accounts
     */
    public static Boolean orgUsesPersonAccounts() {
        return Schema.SObjectType.Account.fields.getMap().containsKey('isPersonAccount');
    }
}
