/**
 * Class: PokemonTriggerHandlerTest.cls
 * Test for: PokemonTriggerHandler.cls
 */
@isTest
private class PokemonTriggerHandlerTest {

    private static final Integer P_MINIMUM = 5;
    private static final Integer P_OFFSET  = 15;
    private static final SObjectUtil UTIL_PKMN  = new SObjectUtil('Pokemon__c');
    private static final List<String> P_GENDERS = new List<String>{'None', 'Male; Female'};
    private static final List<String> P_TYPES   = PokemonTriggerHandlerTest.getAvailableTypes();
    private static final List<String> REGIONS   = PokemonTriggerHandlerTest.getAvailableRegions();

    /**
     * Test data that will be used for every unit test
     */
    @TestSetup
    static void makeData() {
        System.debug('PokemonTriggerHandlerTest');
        System.debug('TestSetup');

        //  Create 5-20 test records
        Integer numberOfPokemon = Integer.valueOf(Math.random() * P_OFFSET) + P_MINIMUM;
        List<Pokemon__c> testPokemon = new List<Pokemon__c>();
        for (Integer pCount = 0; pCount < numberOfPokemon; pCount++) {
            //  Its name
            String pTestName = 'Test pMon #' + String.valueOf(pCount+1);

            //  Its type(s). Randomly assign 1-2 types from the list of known types
            String pTestTypes = '';
            Integer numberOfTypes = Integer.valueOf(Math.random() * 2) + 1;
            for  (Integer tCount = 1; tCount <= numberOfTypes; tCount++) {
                pTestTypes += P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
                if (tCount < numberOfTypes) {
                    pTestTypes += '; ';
                }
            }

            //  Its available genders
            String pTestGender = '';
            pTestGender += P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );

            //  Create and add to list of test pokemon
            testPokemon.add(TestObjectFactory.createSingleTestPokemon(pCount + 1, pTestName, pTestTypes, pTestGender, '', false));
        }
        try {
            insert testPokemon;
            // System.debug('Test pokemon records inserted');
        } catch (Exception e) {
            System.debug('Test pokemon records not inserted:');
            System.debug(e.getMessage());
        }

        Integer pokemonRecordCount = [SELECT Count() FROM Pokemon__c];
        System.assertEquals(numberOfPokemon, pokemonRecordCount, 'The number of records inserted does not match what was expected.');
        System.debug('TestSetup: Success');
    }

    /**
     * Test that new pokemon can be added when there are no trainers in the system
     */
    @isTest
    static void testTriggerWithNoTrainers() {
        System.debug('testTriggerWithNoTrainers');

        //  First set of asserts
        Integer initPokemonRecordCount  = TestObjectFactory.getSObjectRecordCount('Pokemon__c');
        Integer initTrainerPokemonCount = TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c');
        Integer initTrainerCount        = TestObjectFactory.getSObjectRecordCount('Trainer__c');
        System.assert(initPokemonRecordCount >= P_MINIMUM);
        System.assert(initPokemonRecordCount <= (P_MINIMUM + P_OFFSET));
        System.assertEquals(0, initTrainerPokemonCount);
        System.assertEquals(0, initTrainerCount);

        Test.startTest();
        //  Add two more records
        String pOneName   = 'Test pMon #' + String.valueOf(initPokemonRecordCount + 1);
        String pOneGender = P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );
        String pOneType   = P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        String pOneRegion = REGIONS.get( Integer.valueof(Math.random() * REGIONS.size()) );

        String pTwoName   = 'Test pMon #' + String.valueOf(initPokemonRecordCount + 1);
        String pTwoGender = P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );
        String pTwoType   = P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        pTwoType += '; '  + P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        String pTwoRegion = REGIONS.get( Integer.valueof(Math.random() * REGIONS.size()) );

        List<Pokemon__c> newPokemon = new List<Pokemon__c>();
        newPokemon.add( TestObjectFactory.createSingleTestPokemon(initPokemonRecordCount + 1, pOneName, pOneType, pOneGender, pOneRegion, false) );
        newPokemon.add( TestObjectFactory.createSingleTestPokemon(initPokemonRecordCount + 1, pTwoName, pTwoType, pTwoGender, pTwoRegion, false) );
        insert newPokemon;
        Test.stopTest();

        //  Last set of asserts
        Integer postPokemonRecordCount  = TestObjectFactory.getSObjectRecordCount('Pokemon__c');
        Integer postTrainerPokemonCount = TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c');
        Integer postTrainerCount        = TestObjectFactory.getSObjectRecordCount('Trainer__c');
        System.assert(postPokemonRecordCount >= P_MINIMUM + 2);
        System.assert(postPokemonRecordCount <= (P_MINIMUM + P_OFFSET + 2));
        System.assertEquals(0, postTrainerCount);
        System.assertEquals(postPokemonRecordCount * postTrainerCount, postTrainerPokemonCount);

        System.debug('testTriggerWithNoTrainers: Success');
    }    

    /**
     * Test that new pokemon can be added when there is one trainer record
     * and associative records between Pokemon__c and Trainer__c are created
     */
    @isTest
    static void testTriggerWithOneTrainer() {
        System.debug('testTriggerWithOneTrainer');

        //  First set of asserts
        Integer initPokemonRecordCount  = TestObjectFactory.getSObjectRecordCount('Pokemon__c');
        Integer initTrainerPokemonCount = TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c');
        Integer initTrainerCount        = TestObjectFactory.getSObjectRecordCount('Trainer__c');
        System.assert(initPokemonRecordCount >= P_MINIMUM);
        System.assert(initPokemonRecordCount <= (P_MINIMUM + P_OFFSET));
        System.assertEquals(0, initTrainerCount);
        System.assertEquals(0, initTrainerPokemonCount);

        //  Insert new trainer
        SObjectUtil utilTrainer = new SObjectUtil('Trainer__c');
        List<String> gameVersions = new List<String>();
        for (Schema.PicklistEntry ple : utilTrainer.mapPicklistValues.get('Game_Version__c')) {
            gameVersions.add(ple.Label);
        }
        Trainer__c testTrainer = TestObjectFactory.createSingleTestTrainer('Ash Ketchup', gameVersions.get( Integer.valueof(Math.random() * gameVersions.size()) ), true);

        Test.startTest();
        //  Insert two new pokemon
        String pOneName   = 'Test pMon #' + String.valueOf(initPokemonRecordCount + 1);
        String pOneGender = P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );
        String pOneType   = P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        String pOneRegion = REGIONS.get( Integer.valueof(Math.random() * REGIONS.size()) );

        String pTwoName   = 'Test pMon #' + String.valueOf(initPokemonRecordCount + 1);
        String pTwoGender = P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );
        String pTwoType   = P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        pTwoType += '; '  + P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        String pTwoRegion = REGIONS.get( Integer.valueof(Math.random() * REGIONS.size()) );

        List<Pokemon__c> newPokemon = new List<Pokemon__c>();
        newPokemon.add( TestObjectFactory.createSingleTestPokemon(initPokemonRecordCount + 1, pOneName, pOneType, pOneGender, pOneRegion, false) );
        newPokemon.add( TestObjectFactory.createSingleTestPokemon(initPokemonRecordCount + 1, pTwoName, pTwoType, pTwoGender, pTwoRegion, false) );
        insert newPokemon;
        Test.stopTest();

        //  Last set of asserts
        Integer postPokemonRecordCount  = TestObjectFactory.getSObjectRecordCount('Pokemon__c');
        Integer postTrainerPokemonCount = TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c');
        Integer postTrainerCount        = TestObjectFactory.getSObjectRecordCount('Trainer__c');
        System.assert(postPokemonRecordCount >= P_MINIMUM + 2);
        System.assert(postPokemonRecordCount <= (P_MINIMUM + P_OFFSET + 2));
        System.assertEquals(1, postTrainerCount);        
        System.assertEquals(postTrainerCount * postPokemonRecordCount, postTrainerPokemonCount);

        System.debug('testTriggerWithOneTrainer: Success');
    }

    /**
     * Test that new pokemon can be added when there is more than one trainer record
     * and associative records between Pokemon__c and Trainer__c are created
     */
    @isTest
    static void testTriggerWithMoreThanOneTrainer() {
        System.debug('testTriggerWithMoreThanOneTrainer');

        //  First set of asserts
        Integer initPokemonRecordCount  = TestObjectFactory.getSObjectRecordCount('Pokemon__c');
        Integer initTrainerPokemonCount = TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c');
        Integer initTrainerCount        = TestObjectFactory.getSObjectRecordCount('Trainer__c');
        System.assert(initPokemonRecordCount >= P_MINIMUM);
        System.assert(initPokemonRecordCount <= (P_MINIMUM + P_OFFSET));
        System.assertEquals(0, initTrainerCount);
        System.assertEquals(0, initTrainerPokemonCount);

        //  Insert new trainers
        SObjectUtil utilTrainer = new SObjectUtil('Trainer__c');
        List<String> gameVersions = new List<String>();
        for (Schema.PicklistEntry ple : utilTrainer.mapPicklistValues.get('Game_Version__c')) {
            gameVersions.add(ple.Label);
        }
        List<Trainer__c> testTrainers = new List<Trainer__c>();
        testTrainers.add(TestObjectFactory.createSingleTestTrainer('Garry Oats',  gameVersions.get( Integer.valueof(Math.random() * gameVersions.size()) ), false));
        testTrainers.add(TestObjectFactory.createSingleTestTrainer('Ash Ketchup', gameVersions.get( Integer.valueof(Math.random() * gameVersions.size()) ), false));
        insert testTrainers;

        Test.startTest();
        //  Insert two new pokemon
        String pOneName   = 'Test pMon #' + String.valueOf(initPokemonRecordCount + 1);
        String pOneGender = P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );
        String pOneType   = P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        String pOneRegion = REGIONS.get( Integer.valueof(Math.random() * REGIONS.size()) );

        String pTwoName   = 'Test pMon #' + String.valueOf(initPokemonRecordCount + 1);
        String pTwoGender = P_GENDERS.get( Integer.valueof(Math.random() * P_GENDERS.size()) );
        String pTwoType   = P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        pTwoType += '; '  + P_TYPES.get( Integer.valueof(Math.random() * P_TYPES.size()) );
        String pTwoRegion = REGIONS.get( Integer.valueof(Math.random() * REGIONS.size()) );

        List<Pokemon__c> newPokemon = new List<Pokemon__c>();
        newPokemon.add( TestObjectFactory.createSingleTestPokemon(initPokemonRecordCount + 1, pOneName, pOneType, pOneGender, pOneRegion, false) );
        newPokemon.add( TestObjectFactory.createSingleTestPokemon(initPokemonRecordCount + 1, pTwoName, pTwoType, pTwoGender, pTwoRegion, false) );
        insert newPokemon;
        Test.stopTest();

        //  Last set of asserts
        Integer postPokemonRecordCount  = TestObjectFactory.getSObjectRecordCount('Pokemon__c');
        Integer postTrainerPokemonCount = TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c');
        Integer postTrainerCount        = TestObjectFactory.getSObjectRecordCount('Trainer__c');
        System.assert(postPokemonRecordCount >= P_MINIMUM + 2);
        System.assert(postPokemonRecordCount <= (P_MINIMUM + P_OFFSET + 2));
        System.assertEquals(testTrainers.size(), postTrainerCount);        
        System.assertEquals(postTrainerCount * postPokemonRecordCount, postTrainerPokemonCount);

        System.debug('testTriggerWithMoreThanOneTrainer: Success');
    }

    /* Private functions specific for this unit test class */

    /**
     * Returns a list of available know pokemon types
     * @return  List<String>
     */
    private static List<String> getAvailableTypes() {
        List<String> newTypes = new List<String>();
        for (Schema.PicklistEntry ple : UTIL_PKMN.mapPicklistValues.get('Types__c')) {
            newTypes.add(ple.Label);
        }
        return newTypes;
    }

    /**
     * Returns a list of available known pokemon regions
     * @return  List<String>
     */
    private static List<String> getAvailableRegions() {
        List<String> newRegions = new List<String>();
        for (Schema.PicklistEntry ple : UTIL_PKMN.mapPicklistValues.get('Region__c')) {
            newRegions.add(ple.Label);
        }
        return newRegions;
    }
}