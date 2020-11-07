# Salesforce Org Development Org
**Contents**
- Personalised starting org files. ([Fresh Org Branch](https://github.com/Varout/DevOrgSF/tree/fresh-org))
- Completed and in progress Trailhead modules (origin/trailhead/_branch_)
- Completed and in progress Trailhead projects (origin/trailhead-project/_branch_)
- Bits and pieces of code I'm playing around with

Trailhead modules won't be merged into develop.  Trailhead projects will be merged into develop.

## What's In The Fresh Org?
_More details can be found [here](https://github.com/Varout/DevOrgSF/tree/fresh-org)_

- Trigger Framework by Kevin O'Hara ([Github](https://github.com/kevinohara80/sfdc-trigger-framework))
- SObject Utility class by me
- Date Utility class
- Base Test Object Factory
- Base Scheduled Job and Batchable Job classes
- Unit tests for the above (Some are in progress)

## Trailhead Projects Completed
_Currently in progress_

| Project Name   | Github Branch                                    |Description / Trailhead Link                        |
|:---------------|:------------------------------------------------:|:--------------------------------------------------:|
| TBD            | TBD  | [Here](https://trailhead.salesforce.com/projects/) |
| SObjectUtil    | [Here](https://github.com/Varout/SObjectUtil)    |                                                    |

# SOBjectUtil Class Information

## What's It About?

I wanted to be able to get certain bits of information on the fly using code with Salesforce. I was doing a lot of work with picklists at the time and wanted to put something together to help get the information I needed, faster.
This util class helps to get most useful information about an SObject. Including:
- Record types: Id and DeveloperName
- Picklists, and the options available for each picklist (normal and multi)
- A list of the object's fields and their types
- A string with all fields on the object separated by commas, so that the equivalent to `SELECT * FROM SObject` can be used
- Ability to query fields that are of type Lookup or Master-Detail, adding to the feature above

The util also gets information about available SObjects and if the Salesforce Org uses Person Accounts.


## Files

| File Name           | Description          |
|:--------------------|:---------------------|
| SObjectUtil.cls     | The utility class.   |
| SObjectUtilTest.cls | The unit test class. |

## Available Functions

### Static Functions

| Function                               | Return Type   | Description                                                           |
|:---------------------------------------|:--------------|:----------------------------------------------------------------------|
| `SObjectUtil.getSetOfOrgSObjects();`   | `Set<String>` | A set of all SObjects in the Salesforce Org. Including setup objects. |
| `SObjectUtil.orgUsesPersonAccounts();` | `Boolean`     | Returns true if the Salesforce Org uses Person Accounts.              |


### Public Variables

| Name                    | Type                                      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|:------------------------|:------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| selectAllString         | `String`                                  | Contains a comma separated string with all available fields on the object.  e.g "Id, Name, CreatedDate, CreatedById,..." to achieve the equivalent of `SELECT * FROM SObject` in Salesforce.                                                                                                                                                                                                                                                         |
| mapRecordTypeNameToId   | `Map<String, Id>`                         | The Key (String) is the DeveloperName of the record type. The Value (Id) is the Salesforce Id value for that record type.                                                                                                                                                                                                                                                                                                                            |
| mapDevNameToType        | `Map<String, String>`                     | The Key (String) is the DeveloperName of a field on the SObject. The Value (String) is the data type of the field.                                                                                                                                                                                                                                                                                                                                   |
| mapPicklistValues       | `Map<String, List<Schema.PicklistEntry>>` | The Key (String) is the name of a picklist field on the SObject. The Value (List<PicklistEntry>) is a list of PicklistEntry records for the picklist. Which can be used to populate a picklist with available options. More information: <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_PicklistEntry.htm#apex_class_Schema_PicklistEntry" target="_blank">Salesforce: Schema.PicklistEntry</a> |
| mapRelatedSObjectFields | `Map<String, Set<String>>`                | The Key (String) is the name of the SObject. The Values are the field names for all fields on that SObject.                                                                                                                                                                                                                                                                                                                                          |


## Quick How To Use

Say we want to use Account as an example

** Inititalise **

```SObjectUtil accountUtil = new SObjectUtil('Account');```
```SObjectUtil customObjectUtil = new SObjectUtil('MyCustomObject__c');```


** Field String **
For the main SObject that the util has been initiated with, this will return all fields for only that object:
```String accountFields = accountUtil.selectAllString;```

To get fields for all or specific objects that have Lookups or Master-Detail Lookups on this SObject:
```String contactFieldsOnAccount = accountUtil.createQueryStringForRelatedSObject('ContactId');```
```String customObjectFieldsOnAccount = accountUtil.createQueryStringForRelatedSObject('CustomObject__c');```

You can group multiple objects at time in a Set or List
```List<String> sobjs = new List<String>{'ContactId', 'CustomObject__c'};```
```String queryString = accountUtil.createQueryStringForRelatedObjects(sobjs);```

_Example_

```Java
SObjectUtil contractUtil = new SObjectUtil('Contract');
Set<String> testSet = new Set<String>{'AccountId', 'CustoObj__c'};
String queryString = '';
queryString += 'SELECT ' + animalUtil.selectAllString + ',\n';
queryString += animalUtil.createQueryStringForRelatedSObjects(testSet) + '\n';
queryString += ' FROM Contract';
List<SObject> theResults = Database.query(queryString);
```

## Schema.Picklist (Picklist Entry Methods)
SObject detail taken from the Salesforce documentation page
The following are methods for PicklistEntry. All are instance methods.

- getLabel()

`String`. Returns the display name of this item in the picklist.


- getValue()

`String`. Returns the value of this item in the picklist.


- isActive()

`Boolean`. Returns true if this item must be displayed in the drop-down list for the picklist field in the user interface, false otherwise.


- isDefaultValue()

`Boolean`. Returns true if this item is the default value for the picklist, false otherwise. Only one item in a picklist can be designated as the default.
