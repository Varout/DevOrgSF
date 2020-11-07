/**
 * @class:
 * @test:
 * @author
 * @desc: NOT A TESTING UNIT TEST CLASS.  Uses SObjectUtil to create SObjectUtil instances for unit tests
 */
public class TestSObjectUtilFactory {

    public class TestSObjectUtilFactoryException extends Exception {}

    private static TestSObjectUtilFactory theInstance = new TestSObjectUtilFactory();
    public Map<String, SObjectUtil> mapSObjectUtils { get; private set; }

    /**
     * Setup
     */
    private TestSObjectUtilFactory() {
        this.mapSObjectUtils = new Map<String, SObjectUtil>();
    }

    /**
     * Get yo instance
     */
    public static TestSObjectUtilFactory getInstance(Set<String> theSObjectDevNames) {
        if (theSObjectDevNames.size() > 20) {
            throw new TestSObjectUtilFactoryException('You really shouldn\'t be using SObjectUtil with more than 20 SObjects at the same time. You will run into DML limit problems.');
        }
        return TestSObjectUtilFactory.theInstance;
    }

    /**
     *
     */
    private void populateSObjectUtilInstances(Set<String> theSObjectDevNames) {
        List<String> errorObjects = new List<String>();

        for (String sDName : theSObjectDevNames) {
            SObjectUtil tempUtil;
            try {
                tempUtil = new SObjectUtil(sDName);
            } catch (Exception e) {
                //  Create a list of SObject Names that have failed
                errorObjects.add(sDName);
            }

            //  Only add to map if we haven't encountered any errors
            //  No point in filling up memory if we can't use it
            if (errorObjects.isEmpty()) {
                this.mapSObjectUtils.put(sDName,tempUtil);
            }
        }

        //  Throw exception if any failed.  List which failed
        if (!errorObjects.isEmpty()) {
            String brokenSObjects = String.join(errorObjects, ', ');
            String errorString = 'The SObjectUtils weren\'t created because exceptions were thrown for the following SObjects: ' + brokenSObjects + '. Check their API/DeveloperNames and try again.';
            throw new TestSObjectUtilFactoryException(errorString);
        }
    }
}