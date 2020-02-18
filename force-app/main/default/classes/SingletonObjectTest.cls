/**
 * Class: SingletonObjectTest.cls
 * Test for: SingletoneObject.cls
 * @desc: Testing setup and function call for SingletonObject class
 */
@isTest
private class SingletonObjectTest {

    /**
     * Test creating singleton object instance
     */
    @isTest
    static void createSingleInstance() {
        SingletonObject theObject = null;
        Boolean isSuccess = false;
        try {
            theObject = SingletonObject.getIntance();
            isSuccess = true;
        } catch (Exception e) {
            isSuccess = false;
            System.debug(e.getMessage());
        }

        System.assertNotEquals(null, theObject);
        System.assertEquals(1, theObject.initCount);
        System.assertEquals(true, theObject.iHaveBeenCreated);
        System.assertEquals(true, isSuccess);
    }

    /**
     * Test creating a new singleton object instance and check
     * that the object is still the same instance
     */
    @isTest
    static void createSecondInstance() {
        //  Initial setup
        SingletonObject theObject = null;
        Boolean isSuccess = false;
        try {
            theObject = SingletonObject.getIntance();
            // theObject.initCount += 1;

        } catch (Exception e) {
            System.debug('#1: ' + e.getMessage());
        }

        //  Try reate another instance of it
        try {
            theObject = SingletonObject.getIntance();
            isSuccess = true;
        } catch (Exception e) {
            isSuccess = false;
            System.debug('#2: ' + e.getMessage());
        }

        System.assertNotEquals(null, theObject);
        System.assertEquals(true, theObject.iHaveBeenCreated);
        System.assertEquals(2, theObject.initCount);    //  Should be incremented by 1 from trying to create again
        System.assertEquals(true, isSuccess);
    }

    @isTest
    static void testDemoFunction() {
        SingletonObject theObject = null;
        Boolean isSuccess = false;
        try {
            theObject = SingletonObject.getIntance();
            isSuccess = true;
        } catch (Exception e) {
            isSuccess = false;
            System.debug(e.getMessage());
        }

        System.assertNotEquals(null, theObject);
        System.assertEquals(1, theObject.initCount);
        System.assertEquals(true, theObject.iHaveBeenCreated);
        System.assertEquals(true, isSuccess);
        System.assertEquals('Debug output', theObject.demoFunction());
    }
}
