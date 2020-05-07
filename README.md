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
   Related files:
   - classes/TriggerHandler.cls: Main framework class.
   - classes/TriggerHandlerTest.cls: Unit test for main framework class.
   - classes/TriggerExampleHandler.cls: Gives use case example.
   - classes/TriggerExampleHandlerTest.cls: Unit test for the example class.
   - triggers/TriggerExample.trigger: Example trigger file for the framework.

### SObjectUtil
    Written by: Jasón Auger
    Copyright: Jasón Auger. Details in SObjectUtil.cls


## Description of Files and Directories
    - Should be easy to follow
## Might be of interest
    - The *SObjectUtil* class has been put together to make it easier to work with both
      standard and custom Salesforce Objects in an org that a user may or may not be 
      comfortable with.
## Issues
    - None known currently