# Salesforce Org Starting Point

## What is it?
Classes and triggers that I would used in my Salesforce Orgs when starting fresh.
Each utility should have its own example of use class and unit test.


## What do they do?

### Trigger Framework

Written by: Kevin M. O'Hara.

Copyright: Kevin M. O'Hara. Details in TriggerHandler.cls

Github: https://github.com/kevinohara80/sfdc-trigger-framework

A framework to standardise the use of triggers in Salesforce and more easily
extract the logic from the trigger class with a tidy framework.

The naming convention I generally use is:
- Trigger: SObjectTrigger.trigger
- Logic: SObjectTriggerLogic.cls or SObjectHandler.cls

#### Related files
- classes/TriggerHandler.cls: Main framework class.
- classes/TriggerHandlerTest.cls: Unit test for main framework class.
- classes/TriggerExampleHandler.cls: Gives use case example.
- classes/TriggerExampleHandlerTest.cls: Unit test for the example class.
- triggers/TriggerExample.trigger: Example trigger file for the framework.


### SObject Utility

Written by: Jasón Auger

Copyright: Jasón Auger. Details in SObjectUtil.cls

A utility class for Salesforce objects (SObjects). This is meant to make it easier to work
with fields, picklists, record types.  The class is defined **with sharing**.

#### Related Files
- classes/SObjectUtil.cls: Utility class.
- classes/SObjectUtilTest.cls: Unit test class.

#### Examples of Use
- **Initialisation**

| SObject Type             | Example                                                 |
|--------------------------|:-------------------------------------------------------:|
| Standard Object: Account | `SObjectUtil accountUtil = new SObjectUtil('Account');` | 
| Custom Object: Book      | `SObjectUtil bookUtil = new SObjectUtil('Book__c');`    |

- **Available Data**

| Variable Name         | Type                                      | Contents                                                                                                                                                                                       |
|:----------------------|:-----------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| selectAllString       | `String`                                  | A comma separated string with all fields for the SObject to use in place of an Asterisk (*) when you want to query all fields. e.g. "Id, Name, CreatedDate, CreatedBy, etc"                    |
| mapRecordTypeNameToId | `Map<String, Id>`                         | If the SObject has record types, this maps the name of a record type to a record type Id.                                                                                                      |
| mapDevNameToType      | `Map<String, String>`                     | For every field, create a map where the field name is the key, and the value is the type<sup> **1**</sup> of data expected.                                                                    |
| mapPicklistValues     | `Map<String, List<Schema.PicklistEntry>>` | If there are any picklists or multipicklists for the SObject, this map will have the name of the field as the key, and a list of Schema.PicklistEntry<sup> **2**</sup> records for that field. |

- **Public Static Functions**

| Function Name                          | Return Type   | What it returns                                                      |
|:---------------------------------------|:-------------:|:---------------------------------------------------------------------|
| `SObjectUtil.getSetOfOrgSObjects();`   | `Set<String>` | Returns a set of SObject names for available SObjects in Salesforce. |
| `SObjectUtil.orgUsesPersonAccounts();` | `Boolean`     | Returns true if Person Accounts are enabled in this org.             |


### Date Utility
Used to manipulate Dates

#### Related Files
- classes/DateUtil.cls: Utility class.
- classes/DateUtilTest.cls: Unit test class.

#### Available Functions
| Function Name             | Return Type | What it returns | 
|:--------------------------|:-----------:|:----------------|
| `dateToString(Date)`      | `String`    |  |
| `getDateTimeOfDate(Date)` | `DateTie`   |  |
| `monthNameForDate(Date)`  | `String`    |  |
| `dayNameOfWeek(Date)`     | `String`    |  |
| `dayNumberOfWeek(Date)`   | `String`    |  |
| `mondayBefore(Date)`      | `Date`      |  |
| `sundayBefore(Date)`      | `Date`      |  |
| `saturdayAfter(Date)`     | `Date`      |  |
| `fridayAfter(Date)`       | `Date`      |  |

### Test Object Factory
A forever evolving class which contains public static functions which create test data to be used in unit tests. The included file contains some examples for Account and Contact.

#### Related Files
- classes/TestObjectFactory.cls: Where we put our functions used to create test data.  Generally should be `public static`.


## Notes
<sup>1</sup> Available field types are:

`'ADDRESS', 'ANYTYPE', 'BASE64', 'BOOLEAN', 'COMBOBOX', 'CURRENCY',
'DATACATEGORYGROUPREFERENCE', 'DATE', 'DATETIME', 'DOUBLE', 'EMAIL',
'ENCRYPTEDSTRING', 'ID', 'INTEGER', 'LONG', 'MULTIPICKLIST', 'PERCENT',
'PHONE', 'PICKLIST', 'REFERENCE', 'STRING', 'TEXTAREA', 'TIME', 'URL'`

<sup>2</sup> <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_PicklistEntry.htm#apex_class_Schema_PicklistEntry" target="_blank">Salesforce: Schema.PicklistEntry</a>