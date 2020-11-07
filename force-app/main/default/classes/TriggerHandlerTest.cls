/**
 * Class:   TriggerHandlerTest.cls
 * Testing: TriggerHandler.cls
 * 
 * Copyright (c) 2013 Kevin M. O'Hara
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom
 * the Software is furnished to do so, subject to the following
 * conditions:
 * - The above copyright notice and this permission notice shall
 * be included in all copies or substantial portions of the
 * Software.
 * - THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
 * KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * https://github.com/kevinohara80/sfdc-trigger-framework
 */
@isTest
private class TriggerHandlerTest {
    private static final String TRIGGER_CONTEXT_ERROR = 'Trigger handler called outside of Trigger execution';
    private static String lastMethodCalled;
    private static TriggerHandlerTest.TestHandler handler;
    static {
        handler = new TriggerHandlerTest.TestHandler();
        //  Override its internal trigger detection.
        handler.isTriggerExecuting = true;
    }
    
    /***************************************/
    /*                Unit Tests           */
    /***************************************/
    // Contexts Tests
    @isTest
    static void testBeforeInsert() {
        beforeInsertMode();
        handler.run();
        System.assertEquals('beforeInsert', lastMethodCalled, 'Last method should be beforeInsert');
    }

    @isTest
    static void testBeforeUpdate() {
        beforeUpdateMode();
        handler.run();
        System.assertEquals('beforeUpdate', lastMethodCalled, 'Last method should be beforeUpdate');
    }

    @isTest
    static void testBeforeDelete() {
        beforeDeleteMode();
        handler.run();
        System.assertEquals('beforeDelete', lastMethodCalled, 'Last method should be beforeDelete');
    }

    @isTest
    static void testAfterInsert() {
        afterInsertMode();
        handler.run();
        System.assertEquals('afterInsert', lastMethodCalled, 'Last method should be afterInsert');
    }

    @isTest
    static void testAfterUpdate() {
        afterUpdateMode();
        handler.run();
        System.assertEquals('afterUpdate', lastMethodCalled, 'Last method should be afterUpdate');
    }

    @isTest
    static void testAfterDelete() {
        afterDeleteMode();
        handler.run();
        System.assertEquals('afterDelete', lastMethodCalled, 'Last method should be afterDelete');
    }

    @isTest
    static void testAfterUndelete() {
        afterUndeleteMode();
        handler.run();
        System.assertEquals('afterUndelete', lastMethodCalled, 'Last method should be afterUndelete');
    }

    @isTest
    static void testNonTriggerContext() {
        try{
            handler.run();
            System.assert(false, 'The handler ran but should have thrown');
        } catch(TriggerHandler.TriggerHandlerException te) {
            System.assertEquals(TRIGGER_CONTEXT_ERROR, te.getMessage(), 'The exception message should match');
        } catch(Exception e) {
            System.assert(false, 'The exception thrown was not expected: ' + e.getTypeName() + ': ' + e.getMessage());
        }
    }

    /**
     * Test Bypass API
     */
    @isTest
    static void testBypassAPI() {
        afterUpdateMode();

        //  Test a bypass and run handler
        TriggerHandler.bypass('TestHandler');
        handler.run();
        System.assertEquals(null, lastMethodCalled, 'Last method should be null when bypassed');
        System.assertEquals(true, TriggerHandler.isBypassed('TestHandler'), 'Test handler should be bypassed');
        resetTest();

        //  Clear that bypass and run handler
        TriggerHandler.clearBypass('TestHandler');
        handler.run();
        System.assertEquals('afterUpdate', lastMethodCalled, 'Last method called should be afterUpdate');
        System.assertEquals(false, TriggerHandler.isBypassed('TestHandler'), 'Test handler should be bypassed');
        resetTest();

        //  Test a re-bypass and run handler
        TriggerHandler.bypass('TestHandler');
        handler.run();
        System.assertEquals(null, lastMethodCalled, 'last method should be null when bypassed');
        System.assertEquals(true, TriggerHandler.isBypassed('TestHandler'), 'Test handler should be bypassed');
        resetTest();

        //  Clear all bypasses and run handler
        TriggerHandler.clearAllBypasses();
        handler.run();
        System.assertEquals('afterUpdate', lastMethodCalled, 'Last method called should be afterUpdate');
        System.assertEquals(false, TriggerHandler.isBypassed('TestHandler'), 'Test handler should be bypassed');
        resetTest();
    }

    /**
     * Instance Method Tests
     */
    @isTest
    static void testLoopCount() {
        beforeInsertMode();

        //  Set the max loops to 2
        handler.setMaxLoopCount(2);
        //  Run the handler twice
        handler.run();
        handler.run();
        //  Clear the tests
        resetTest();
        try {
        //  Try running it. This should exceed the limit.
            handler.run();
            System.assert(false, 'The handler should throw on the 3rd run when maxloopcount is 3');
        } catch(TriggerHandler.TriggerHandlerException te) {
            //  We're expecting to get here
            System.assertEquals(null, lastMethodCalled, 'Last method should be null');
        } catch(Exception e) { 
            System.assert(false, 'The exception thrown was not expected: ' + e.getTypeName() + ': ' + e.getMessage());
        }
        //  Clear the tests
        resetTest();
        //  Now clear the loop count
        handler.clearMaxLoopCount();
        try {
            //  Re-run the handler. We shouldn't throw now.
            handler.run();
            System.assertEquals('beforeInsert', lastMethodCalled, 'last method should be beforeInsert');
        } catch(TriggerHandler.TriggerHandlerException te) {
            System.assert(false, 'running the handler after clearing the loop count should not throw');
        } catch(Exception e) { 
            System.assert(false, 'the exception thrown was not expected: ' + e.getTypeName() + ': ' + e.getMessage());
        }
    }

    @isTest
    static void testLoopCountClass() {
        TriggerHandler.LoopCount lc = new TriggerHandler.LoopCount();
        System.assertEquals(5, lc.getMax(), 'max should be five on init');
        System.assertEquals(0, lc.getCount(), 'count should be zero on init');
        lc.increment();
        System.assertEquals(1, lc.getCount(), 'count should be 1');
        System.assertEquals(false, lc.exceeded(), 'should not be exceeded with count of 1');
        lc.increment();
        lc.increment();
        lc.increment();
        lc.increment();
        System.assertEquals(5, lc.getCount(), 'count should be 5');
        System.assertEquals(false, lc.exceeded(), 'should not be exceeded with count of 5');
        lc.increment();
        System.assertEquals(6, lc.getCount(), 'count should be 6');
        System.assertEquals(true, lc.exceeded(), 'should not be exceeded with count of 6');
    }
     
    /** 
     * Private method tests
     */
    @isTest
    static void testGetHandlerName() {
        System.assertEquals('TestHandler', handler.getHandlerName(), 'handler name should match class name');
    }
    
    /** 
     * Test virtual methods
     */
    @isTest
    static void testVirtualMethods() {
        TriggerHandler h = new TriggerHandler();
        h.beforeInsert();
        h.beforeUpdate();
        h.beforeDelete();
        h.afterInsert();
        h.afterUpdate();
        h.afterDelete();
        h.afterUndelete();
    }

    /****************************************/
    /*           Testing Utilities          */
    /****************************************/
    private static void resetTest() {
        lastMethodCalled = null;
    }
    //  Modes for testing
    private static void beforeInsertMode() {
        handler.setTriggerContext('before insert', true);
    }
    private static void beforeUpdateMode() {
        handler.setTriggerContext('before update', true);
    }
    private static void beforeDeleteMode() {
        handler.setTriggerContext('before delete', true);
    }
    private static void afterInsertMode() {
        handler.setTriggerContext('after insert', true);
    }
    private static void afterUpdateMode() {
        handler.setTriggerContext('after update', true);
    }
    private static void afterDeleteMode() {
        handler.setTriggerContext('after delete', true);
    }
    private static void afterUndeleteMode() {
        handler.setTriggerContext('after undelete', true);
    }

    /**
     * Test implementation of the TriggerHandler
     */
    private class TestHandler extends TriggerHandler {
        public override void beforeInsert() {
            TriggerHandlerTest.lastMethodCalled = 'beforeInsert';
        }
        public override void  beforeUpdate() {
            TriggerHandlerTest.lastMethodCalled = 'beforeUpdate';
        }
        public override void beforeDelete() {
            TriggerHandlerTest.lastMethodCalled = 'beforeDelete';
        }
        public override void afterInsert() {
            TriggerHandlerTest.lastMethodCalled = 'afterInsert';
        }
        public override void afterUpdate() {
            TriggerHandlerTest.lastMethodCalled = 'afterUpdate';
        }
        public override void afterDelete() {
            TriggerHandlerTest.lastMethodCalled = 'afterDelete';
        }
        public override void afterUndelete() {
            TriggerHandlerTest.lastMethodCalled = 'afterUndelete';
        }
    }
}