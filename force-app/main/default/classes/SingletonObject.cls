/**
 * Class: SingletonObject.cls
 * @desc: The singleton design pattern comes under creational pattern as 
 *        this pattern provides one of the best ways to create an object.
 */
public class SingletonObject {

    private static SingletonObject singletonInstance = new SingletonObject();

    /**
     * Private constructor
     */
    private SingletonObject() {}

    /**
     * Return instance of singleton
     */
    public static SingletonObject getIntance() {
        return singletonInstance;
    }

    /**
     * Example of a function
     */
    public void demoFunction() {
        System.debug('Debug output');
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