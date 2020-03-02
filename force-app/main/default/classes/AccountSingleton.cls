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
    private Map<String, List<String>> mapPicklistFieldLists { get; set; }

    /* ------------------- */
    /*  Private functions  */
    /* ------------------- */
    
    private AccountSingleton() {
        this.populateRecordTypes();
        this.populateFieldNameTypes();
        // this.listOfPicklistFields = populatePicklistFields();
    }

    //  Populate Account record type information
    private void populateRecordTypes() {
        this.mapRecordTypeName = new Map<String, RecordType>();

        for (RecordType rt : [
                                 SELECT Id, Name, DeveloperName, IsActive, SObjectType, Description
                                 FROM RecordType
                                 WHERE SObjectType = 'Account'
                             ]) {
            if (rt.IsActive) {
                this.mapRecordTypeName.put(rt.DeveloperName, rt);
            }
        }
    }

    //  Populate Account field information
    private void populateFieldNameTypes() {
        this.mapFieldNameType = new Map<String, String>();

        //  Get and sort here

    }

    //  Populate information for all picklist fields on Account
    private Set<String> populatePicklistFields() {
        Set<String> returnSet = new Set<String>();
        return null;
    }

    private Map<String, List<String>> populatePicklistOptions() {
        Map<String, List<String>> returnMap = new Map<String, List<String>>();
        return null;
    }

    /* ------------------ */
    /*  Public functions  */
    /* ------------------ */
    public static AccountSingleton getInstance() {
        return accountInstance;
    }

    //  Record Type related
    public Map<String, RecordType> getRecordTypes() {
        return this.mapRecordTypeName;
    }

    //  Allows user to get the Id of a record type from the DeveloperName
    public Id getRecordTypeIdFromName(String rtName) {
        if (this.mapRecordTypeName.keySet().contains(rtName)) {
            return this.mapRecordTypeName.get(rtName).Id;
        } else {
            return null;
        }
    }

    //  
    public Map<String, List<String>> getPicklistsAndValues() {
        if (!this.mapPicklistFieldLists.isEmpty()) {
            return this.mapPicklistFieldLists;
        } else {
            return null;
        }
    }

/**
 * If is picklist: getPicklistValues() - List<Schema.PicklistEntry> ple;
 * If is integer: getDigits() - Max length
 * If is double: getPrecision() - Max length
 * If is double: getScale() - Number of digits to the right of decimal point
 */

}
