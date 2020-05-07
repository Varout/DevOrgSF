/**
 * Class: SingletonObject.cls
 * @desc: The singleton design pattern comes under creational pattern as 
 *        this pattern provides one of the best ways to create an object.
 */
public class SingletonObject {

    private static SingletonObject singletonInstance = new SingletonObject();
    public Boolean iHaveBeenCreated { get; private set; }
    public Integer initCount { get; private set; }

    /**
     * Private constructor
     */
    private SingletonObject() {
        this.iHaveBeenCreated = true;
        this.initCount = 0;     //  Used to display how many times the Singleton has been instanced.
    }

    /**
     * Return instance of singleton
     */
    public static SingletonObject getIntance() {
        singletonInstance.initCount += 1;
        return singletonInstance;
    }

    /**
     * Example of a function
     */
    public String demoFunction() {
        String returnString = 'Debug output';
        System.debug(returnString);
        return returnString;
    }
}

/*
    //  Example of how to use the pattern
    class public ClassName {
        public ClassName() {
            //  Right way: Works because of static method getInstance()
            SingletonObject theObject = SingletonObject.getInstance();

            //  Wrong way: The constructor has been purposefully made private
            //  Will not compile
            //  SingletonObject theObject = new SingletonObject();

            theObject.demoFunction();
        }
    }

*/