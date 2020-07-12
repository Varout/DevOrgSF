/**
 * Class:   ExampleTriggerHandlerTest.cls
 * Testing: ExampleTriggerHandler.cls
 */
@isTest
private class ExampleTriggerHandlerTest {
    @testSetup
    static void makeData() {
        //  Put setup data here
    }

    @isTest
    static void testExampleBeforeFunction() {
        //  Calling directly
        ExampleTriggerHandler theTriggerHandler = new ExampleTriggerHandler();
        theTriggerHandler.exampleBeforeFunction();
    }

    @isTest 
    static void testExampleAfterFunction() {
        ExampleTriggerHandler theTriggerHandler = new ExampleTriggerHandler();
        theTriggerHandler.exampleAfterFunction();
    }

    @isTest
    static void testExampleBeforeFunctionParam() {
        List<Account> theAccounts = new List<Account>();
        ExampleTriggerHandler theTriggerHandler = new ExampleTriggerHandler();
        theTriggerHandler.exampleBeforeFunctionParam(theAccounts);
    }
}