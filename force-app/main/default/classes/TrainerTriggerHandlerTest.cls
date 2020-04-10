/**
 * Class: TrainerTriggerHandlerTest.cls
 * Test for: TrainerTriggerHandler.cls
 */
@isTest
private class TrainerTriggerHandlerTest {

    private static final Integer P_MINIMUM = 5;
    private static final Integer P_OFFSET  = 15;
    private static final SObjectUtil UTIL_PKMN        = new SObjectUtil('Pokemon__c');
    private static final SObjectUtil UTIL_TRNR        = new SObjectUtil('Trainer__c');
    private static final List<String> P_GENDERS       = new List<String>{'None', 'Male; Female'};
    private static final List<String> P_TYPES         = TrainerTriggerHandlerTest.getAvailableTypes();
    private static final List<String> P_REGIONS       = TrainerTriggerHandlerTest.getAvailableRegions();
    private static final List<String> T_GAME_VERSIONS = TrainerTriggerHandlerTest.getAvailableVersions();

    /**
     * Insert a new trainer while no pokemon and no trainers
     */
    @isTest
    static void testOne() {
        //  Test initial record counts
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));

        Test.startTest();
        //  Create and insert test trainer record
        String trainerName = 'Ash Ketchup';
        Trainer__c testTrainer = TestObjectFactory.createSingleTestTrainer(trainerName, T_GAME_VERSIONS.get( Integer.valueof(Math.random() * T_GAME_VERSIONS.size()) ), true);
        //  Query trainer record
        Trainer__c queryTrainer = [
            SELECT Id, Name, Game_Version__c, Total_Unique_Caught__c, Total_Available_Pokemon__c
            FROM Trainer__c
            WHERE Id = :testTrainer.Id
        ];
        Test.stopTest();

        //  Test final record counts
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(1, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));
        System.assertNotEquals(null, queryTrainer.Id);
        System.assertEquals(trainerName, queryTrainer.Name);
        System.assert(T_GAME_VERSIONS.contains(queryTrainer.Game_Version__c));
        System.assertEquals(0, queryTrainer.Total_Unique_Caught__c);
        System.assertEquals(0, queryTrainer.Total_Available_Pokemon__c);
    }

    /**
     * Insert a new trainer while no pokemon, but existing trainers
     */
    @isTest
    static void testTwo() {
        //  Existing trainer
        String trainerName1 = 'Ash Ketchup';
        Trainer__c testTrainer1 = TestObjectFactory.createSingleTestTrainer(trainerName1, T_GAME_VERSIONS.get( Integer.valueof(Math.random() * T_GAME_VERSIONS.size()) ), true);
        //  Test initial record counts
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(1, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));

        Test.startTest();
        //  Create and insert test trainer record
        String trainerName2 = 'Gravy Oats';
        Trainer__c testTrainer2 = TestObjectFactory.createSingleTestTrainer(trainerName2, T_GAME_VERSIONS.get( Integer.valueof(Math.random() * T_GAME_VERSIONS.size()) ), true);
        //  Query trainer record
        Trainer__c queryTrainer = [
            SELECT Id, Name, Game_Version__c, Total_Unique_Caught__c, Total_Available_Pokemon__c
            FROM Trainer__c
            WHERE Id = :testTrainer2.Id
        ];
        Test.stopTest();

        //  Test final record counts
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(2, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));
        System.assertNotEquals(null, queryTrainer.Id);
        System.assertEquals(trainerName2, queryTrainer.Name);
        System.assert(T_GAME_VERSIONS.contains(queryTrainer.Game_Version__c));
        System.assertEquals(0, queryTrainer.Total_Unique_Caught__c);
        System.assertEquals(0, queryTrainer.Total_Available_Pokemon__c);
    }

    /**
     * Insert a new trainer with existing pokemon, but no trainers
     */
    @isTest
    static void testThree() {
        List<Pokemon__c> testPokemon = TrainerTriggerHandlerTest.createTestPokemonRecords();
        //  Test initial record counts
        System.assertEquals(testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(0, TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));

        Test.startTest();
        //  Create and insert test trainer record
        String trainerName = 'Gravy Oats';
        Trainer__c testTrainer = TestObjectFactory.createSingleTestTrainer(trainerName, T_GAME_VERSIONS.get( Integer.valueof(Math.random() * T_GAME_VERSIONS.size()) ), true);
        //  Query trainer record
        Trainer__c queryTrainer = [
            SELECT Id, Name, Game_Version__c, Total_Unique_Caught__c, Total_Available_Pokemon__c
            FROM Trainer__c
            WHERE Id = :testTrainer.Id
        ];
        Test.stopTest();

        //  Test final record counts
        System.assertEquals(testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(1, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(1 * testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));
        System.assertNotEquals(null, queryTrainer.Id);
        System.assertEquals(trainerName, queryTrainer.Name);
        System.assert(T_GAME_VERSIONS.contains(queryTrainer.Game_Version__c));
        System.assertEquals(0, queryTrainer.Total_Unique_Caught__c);
        System.assertEquals(testPokemon.size(), queryTrainer.Total_Available_Pokemon__c);
    }

    /**
     * Insert a new trainer with existing pokemon and trainers
     */
    @isTest
    static void testFour() {
        //  Existing trainer
        String trainerName1 = 'Ash Ketchup';
        Trainer__c testTrainer1 = TestObjectFactory.createSingleTestTrainer(trainerName1, T_GAME_VERSIONS.get( Integer.valueof(Math.random() * T_GAME_VERSIONS.size()) ), true);
        //  Existing pokemon
        List<Pokemon__c> testPokemon = TrainerTriggerHandlerTest.createTestPokemonRecords();
        //  Test initial record counts
        System.assertEquals(testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(1, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(1 * testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));

        Test.startTest();
        //  Create and insert test trainer record
        String trainerName2 = 'Gravy Oats';
        Trainer__c testTrainer2 = TestObjectFactory.createSingleTestTrainer(trainerName2, T_GAME_VERSIONS.get( Integer.valueof(Math.random() * T_GAME_VERSIONS.size()) ), true);
        //  Query trainer record
        Trainer__c queryTrainer = [
            SELECT Id, Name, Game_Version__c, Total_Unique_Caught__c, Total_Available_Pokemon__c
            FROM Trainer__c
            WHERE Id = :testTrainer2.Id
        ];
        Test.stopTest();

        //  Test final record counts
        System.assertEquals(testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Pokemon__c'));
        System.assertEquals(2, TestObjectFactory.getSObjectRecordCount('Trainer__c'));
        System.assertEquals(2 * testPokemon.size(), TestObjectFactory.getSObjectRecordCount('Trainer_Pokemon__c'));
        System.assertNotEquals(null, queryTrainer.Id);
        System.assertEquals(trainerName2, queryTrainer.Name);
        System.assert(T_GAME_VERSIONS.contains(queryTrainer.Game_Version__c));
        System.assertEquals(0, queryTrainer.Total_Unique_Caught__c);
        System.assertEquals(testPokemon.size(), queryTrainer.Total_Available_Pokemon__c);
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

    /**
     * Returns a list of available known game versions
     * @return  List<String>
     */
    private static List<String> getAvailableVersions() {
        List<String> newVersions = new List<String>();
        for (Schema.PicklistEntry ple : UTIL_TRNR.mapPicklistValues.get('Game_Version__c')) {
            newVersions.add(ple.Label);
        }
        return newVersions;
    }

    /**
     * Creates a random amount of test pokemon records
     * @return  List<Pokemon__c>
     */
    private static List<Pokemon__c> createTestPokemonRecords() {
        Integer numberOfPokemon = Integer.valueOf(Math.random() * P_OFFSET) + P_MINIMUM;
        List<Pokemon__c> testPokemon = new List<Pokemon__c>();
        for (Integer pCount = 0; pCount < numberOfPokemon; pCount++) {
            //  Its name
            String pTestName = 'Test pMon #' + String.valueOf(pCount+1);

            //  Its type(s): Randomly assign 1-2 types from the list of known types
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
            System.debug('Test pokemon records inserted');
        } catch (Exception e) {
            System.debug('Test pokemon records not inserted:');
            System.debug(e.getMessage());
        }

        Integer pokemonRecordCount = [SELECT Count() FROM Pokemon__c];
        System.assertEquals(numberOfPokemon, pokemonRecordCount, 'The number of records inserted does not match what was expected.');

        return testPokemon;
    }
}
