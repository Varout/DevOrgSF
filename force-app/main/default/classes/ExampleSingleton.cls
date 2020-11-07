/**
 * Class: ExampleSingleton.cls
 * Test:  ExampleSingletonTest.cls
 * @desc: The singleton design pattern comes under creational pattern as 
 *        this pattern provides one of the best ways to create an object.
 */
public class ExampleSingleton {
    private static ExampleSingleton singletonInstance = new ExampleSingleton();
    public Boolean iHaveBeenCreated { get; private set; }
    public Integer initCount { get; private set; }

    /**
     * Private constructor
     */
    private ExampleSingleton() {
        this.iHaveBeenCreated = true;
        this.initCount = 0;     //  Used to display how many times the Singleton has been instanced.
    }

    /**
     * Return instance of singleton
     */
    public static ExampleSingleton getIntance() {
        singletonInstance.initCount += 1;
        return singletonInstance;
    }

    /**
     * Example of a non-static function
     */
    public String demoFunction() {
        String returnString = 'Debug output';
        System.debug(returnString);
        return returnString;
    }
/*
    //  Example of how to use the pattern
    class public ClassName {
        public ClassName() {
            //  Right way: Works because of static method getInstance()
            ExampleSingleton theObject = ExampleSingleton.getInstance();

            //  Wrong way: The constructor has been purposefully made private
            //  Will not compile
            //  ExampleSingleton theObject = new ExampleSingleton();

            theObject.demoFunction();
        }
    }
*/
}