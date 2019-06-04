public class StringArrayTest {
    public static List<String> generateStringArray(Integer numberOfStrings) {
        List<String> returnStrings = new List<String>();
        
        if (numberOfStrings == 0) {
            return returnStrings;
        } else {
            System.debug(numberOfStrings);
            for (Integer stringCount = 0; stringCount < numberOfStrings; stringCount++) {
                returnStrings.add('Test ' + String.valueOf(stringCount));
                // System.debug('Test ' + String.valueOf(stringCount));
            }
            // System.debug(returnStrings);
            return returnStrings;
        }
    }
}