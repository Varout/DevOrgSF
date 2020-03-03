/**
 * Class: AccountSingleton.cls
 * @desc: Example of using a singleton pattern for getting things like record types
 *        or a list of certain fields for the Account SObject, to help lessen the
 *        amount of possible calls and apex transaction limits
 */
public with sharing class AccountSingleton {
    private static AccountSingleton accountInstance = new AccountSingleton();
    private Map<String, RecordType> mapRecordTypeName { get; set; }
    private Map<String, String> mapFieldNameType { get; set; }
    private Map<String, List<Schema.PicklistEntry>> mapPicklistFieldLists { get; set; }
    private Map<String, Schema.SObjectField> mapAccFields { get; set; }
    public Integer randomTestNumber { get; private set; }
    final private Set<String> ENUM_PICKLISTS = new Set<String>{'PICKLIST', 'MULTIPICKLIST'};

    /* ------------------- */
    /*  Private functions  */
    /* ------------------- */

    /**
     * Class constructor
     */
    private AccountSingleton() {
        SObjectType accountType = Schema.getGlobalDescribe().get('Account');
        this.mapAccFields = accountType.getDescribe().fields.getMap();

        this.randomTestNumber = Integer.valueOf(Math.round(Math.random() * 1000));    //  Only used in unit tests

        this.populateRecordTypes();
        this.populateFieldNameTypes();
    }

    /**
     * Populate the mapRecordTypeName map
     */
    private void populateRecordTypes() {
        this.mapRecordTypeName = new Map<String, RecordType>();

        for (RecordType rt : this.queryRecordTypes()) {
            if (rt.IsActive) {
                this.mapRecordTypeName.put(rt.DeveloperName, rt);
            }
        }
    }

    /**
     * Populate the map of field names to their enum types
     * If picklists exist for Account, then populates the map of
     * picklist field names to a list of picklist options
     * Populates the maps:
     * - Map<String, String> this.mapFieldNameType
     * - Map<String, List<Schema.PicklistEntry>> this.mapPicklistFieldLists
     */
    private void populateFieldNameTypes() {
        this.mapFieldNameType = new Map<String, String>();
        this.mapPicklistFieldLists = new Map<String, List<Schema.PicklistEntry>>();

        for (String fieldKey : this.mapAccFields.keySet()) {
            //  Populdate map of FieldName to FieldType
            String fieldName = this.mapAccFields.get(fieldKey).getDescribe().getName();
            String fieldType = String.valueOf(this.mapAccFields.get(fieldKey).getDescribe().getType());
            this.mapFieldNameType.put(fieldName, fieldType);

            //  Populate map of FieldName to PicklistValues for any picklist field type
            if (this.ENUM_PICKLISTS.contains(fieldType.toUpperCase())) {
                this.mapPicklistFieldLists.put(fieldName, this.mapAccFields.get(fieldKey).getDescribe().getPicklistValues());
            }
        }
    }

    /**
     * Uses a SOQL query to get all record types for the account sobject
     * @return  List<RecordType>
     */
    private List<RecordType> queryRecordTypes() {
        return [
            SELECT Id, Name, DeveloperName, IsActive, SObjectType, Description
            FROM RecordType
            WHERE SObjectType = 'Account'
        ];
    }

    /* ------------------ */
    /*  Public functions  */
    /* ------------------ */

    /**
     * Main function for the Singleton Pattern
     */
    public static AccountSingleton getInstance() {
        return accountInstance;
    }

    /**
     * Returns a map of record type name to record type record
     */
    public Map<String, RecordType> getRecordTypes() {
        return this.mapRecordTypeName;
    }

    /**
     * Allows user to get the Id of a record type from the DeveloperName
     */
    public Id getRecordTypeIdFromName(String rtName) {
        if (this.mapRecordTypeName.keySet().contains(rtName)) {
            return this.mapRecordTypeName.get(rtName).Id;
        } else {
            return null;
        }
    }

    /**
     * Returns the mapFieldNameType map which is a map of Account.Field.DeveloperName
     * to Account.Field.Type
     */
    public Map<String, String> getMapFieldNameType() {
        if (!this.mapFieldNameType.isEmpty()) {
            return this.mapFieldNameType;
        } else {
            return null;
        }
    }

    /**
     * Returns the map this.mapPIcklistFieldLists for Account if it has
     * been populated, else returns null. To access the different data
     * from Schema.PicklistEntry records check the following link:
     * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_PicklistEntry.htm#apex_class_Schema_PicklistEntry
     * @return  Map<String, List<Schema.PicklistEntry>>
     */
    public Map<String, List<Schema.PicklistEntry>> getPicklistsAndValues() {
        if (!this.mapPicklistFieldLists.isEmpty()) {
            return this.mapPicklistFieldLists;
        } else {
            return null;
        }
    }
}
