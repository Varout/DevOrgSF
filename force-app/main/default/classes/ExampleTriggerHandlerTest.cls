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
        TriggerExampleHandler theTriggerHandler = new TriggerExampleHandler();
        theTriggerHandler.exampleBeforeFunction();
    }

    @isTest 
    static void testExampleAfterFunction() {
        TriggerExampleHandler theTriggerHandler = new TriggerExampleHandler();
        theTriggerHandler.exampleAfterFunction();
    }

    @isTest
    static void testExampleBeforeFunctionParam() {
        List<Account> theAccounts = new List<Account>();
        TriggerExampleHandler theTriggerHandler = new TriggerExampleHandler();
        theTriggerHandler.exampleBeforeFunctionParam(theAccounts);
    }
}