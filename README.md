# Salesforce Org Starting Point

## What is it?
Classes and triggers that I would used in my Salesforce Orgs when starting fresh.
Each utility should have its own example of use class and unit test.

### Where can I find it
- [Fresh Org Branch](https://github.com/Varout/DevOrgSF/tree/fresh-org)

## What do they do?

### Trigger Framework

Written by: Kevin M. O'Hara.

Copyright: Kevin M. O'Hara. Details in TriggerHandler.cls.

Github: https://github.com/kevinohara80/sfdc-trigger-framework

A framework to standardise the use of triggers in Salesforce and more easily extract the logic from the trigger class with a tidy framework.

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

Written by: Jasón Auger.

Copyright: Jasón Auger. Details in SObjectUtil.cls.

A utility class for Salesforce objects (SObjects). This is meant to make it easier to work with fields, picklists, record types.  The class is defined **with sharing**.

#### Related Files
- classes/SObjectUtil.cls: Utility class.
- classes/SObjectUtilTest.cls: Unit test class.

#### Examples of Use
- **Initialisation**

| SObject Type             | Example                                                 |
|--------------------------|:--------------------------------------------------------|
| Standard Object: Account | `SObjectUtil accountUtil = new SObjectUtil('Account');` | 
| Custom Object: Book      | `SObjectUtil bookUtil = new SObjectUtil('Book__c');`    |

- **Available Data**

| Variable Names (e.g. `accountUtil` above) | Type                                      | Contents                                                                                                                                                                                       |
|:------------------------------------------|:------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `accountUtil.selectAllString`             | `String`                                  | A comma separated string with all fields for the SObject to use in place of an Asterisk (*) when you want to query all fields. e.g. "Id, Name, CreatedDate, CreatedBy, etc".                   |
| `accountUtil.mapRecordTypeNameToId`       | `Map<String, Id>`                         | If the SObject has record types, this maps the name of a record type to a record type Id.                                                                                                      |
| `accountUtil.mapDevNameToType`            | `Map<String, String>`                     | For every field, create a map where the field name is the key, and the value is the type<sup> **1**</sup> of data expected.                                                                    |
| `accountUtil.mapPicklistValues`           | `Map<String, List<Schema.PicklistEntry>>` | If there are any picklists or multipicklists for the SObject, this map will have the name of the field as the key, and a list of Schema.PicklistEntry<sup> **2**</sup> records for that field. |

- **Public Static Functions**

| Function Name                          | Return Type   | What it returns                                                      |
|:---------------------------------------|:--------------|:---------------------------------------------------------------------|
| `SObjectUtil.getSetOfOrgSObjects();`   | `Set<String>` | Returns a set of SObject names for available SObjects in Salesforce. |
| `SObjectUtil.orgUsesPersonAccounts();` | `Boolean`     | Returns true if Person Accounts are enabled in this org.             |


### Date Utility
Used to manipulate Dates.

#### Related Files
- classes/DateUtil.cls: Utility class.
- classes/DateUtilTest.cls: Unit test class.

#### Available Functions
| Function Name                       | Return Type | What it returns                                                                              |
|:------------------------------------|:------------|:---------------------------------------------------------------------------------------------|
| `DateUtil.dateToString(Date);`      | `String`    | For a given Date, convert it to a String with the format: YYYY-MM-DD.                        |
| `DateUtil.getDateTimeOfDate(Date);` | `DateTine`  | For a given Date, return it as a DateTime at midday the same day.                            |
| `DateUtil.monthNameForDate(Date);`  | `String`    | For a given Date, return the name of the Month.                                              |
| `DateUtil.dayNameOfWeek(Date);`     | `String`    | For a given Date, return the name of the day of the week.                                    |
| `DateUtil.dayNumberOfWeek(Date);`   | `String`    | For a given Date, return the position of the day where 1 = Monday, and 7 = Sunday.           |
| `DateUtil.mondayBefore(Date);`      | `Date`      | For a given Date, return the Monday before. If the day is a Monday, return the same Date.    |
| `DateUtil.sundayBefore(Date);`      | `Date`      | For a given Date, return the Sunday before. If the day is a Sunday, return the same Date.    |
| `DateUtil.saturdayAfter(Date);`     | `Date`      | For a given Date, return the Saturday after. If the day is a Saturday, return the same Date. |
| `DateUtil.fridayAfter(Date);`       | `Date`      | For a given Date, return the Friday after. If the day is a Friday, return the same Date.     |


### Test Object Factory
A forever evolving class which contains public static functions which create test data to be used in unit tests. The included file contains some examples for Account and Contact.

#### Related Files
- classes/TestObjectFactory.cls: Where we put our functions used to create test data.  Generally should be `public static`.

### Scheduled Jobs & Batchable Code
Examples of Scheduled Jobs<sup> **3**</sup> and Batchable Jobs<sup> **4**</sup> have been included here.

#### Related Files
- classes/BatchExample.cls
- classes/BatchExampleTest.cls
- classes/ScheduleExample.cls
- classes/ScheduleExampleTest.cls


## Additional Notes
<sup>1</sup> Available field types are:

`'ADDRESS', 'ANYTYPE', 'BASE64', 'BOOLEAN', 'COMBOBOX', 'CURRENCY',
'DATACATEGORYGROUPREFERENCE', 'DATE', 'DATETIME', 'DOUBLE', 'EMAIL',
'ENCRYPTEDSTRING', 'ID', 'INTEGER', 'LONG', 'MULTIPICKLIST', 'PERCENT',
'PHONE', 'PICKLIST', 'REFERENCE', 'STRING', 'TEXTAREA', 'TIME', 'URL'`

<sup>2</sup> <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_PicklistEntry.htm#apex_class_Schema_PicklistEntry" target="_blank">Salesforce: Schema.PicklistEntry</a>

<sup>3</sup> <a href="https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_scheduled" target="_blank">Salesforce Trailhead: Scheduled Jobs</a>

<sup>4</sup> <a href="https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_batch" target="_blank">Salesforce Trailhead: Batchable Jobs</a>
