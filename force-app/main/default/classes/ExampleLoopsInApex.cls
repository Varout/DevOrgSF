/**
 * Class: ExampleLoopsInApex.cls
 * @desc: Different types of loops in Salesforce-Apex land
 */
public class ExampleLoopsInApex {
    public ExampleLoopsInApex() {}

    /**
     * Remember to have the exit state correct
     */
    public void forLoopStandard() {
        for (Integer iteratorr = 0; iteratorr < 5; iteratorr++) {
            //  Starting at 0, increasing by 1 each time, and while less than 5
            //  Do this code
        }
    }

    /**
     * Personal favourite
     */
    public void forLoopSetListIteration(List<SObject> listOfRecords, Set<Id> setOfIds) {
        for (SObject theRecord : listOfRecords) {
            //  Do the same thing for each record
        }
        for (Id theId : setOfIds) {
            //  Do the same thing with each Id
        }
    }

    /**
     * Remember to have an exit state
     */
    public void whileLoop() {
        Integer counterLimit = 10;
        Integer counter = 0;
        while (counter < counterLimit) {
            //  Do the thing while the counter is less than the counter limit

            //  At the end, increment the counter, otherwise we'll be here forever
            counter++;
        }

        Boolean continueToLoop = true;
        while (continueToLoop) {
            //  Do these things while the Boolean is true

            //  A certain thing happens and it's set to false, the loop stops
            continueToLoop = false;
        }

        while (true) {
            //  Do these things until the loop is broken.  Similar to above

            //  Condition is met
            break;
        }
    }

}