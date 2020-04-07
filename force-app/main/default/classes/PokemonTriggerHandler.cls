/**
 * Class: PokemonTriggerHandler.cls
 * Test: PokemonTriggerHandlerTest.cls
 */
public class PokemonTriggerHandler extends TriggerHandler{

    public override void beforeInsert() {}
    public override void beforeUpdate() {}
    public override void beforeDelete() {}

    public override void afterInsert() {
        this.createNewTrainerPokemonLink(Trigger.new);
    }

    public override void afterUpdate() {}
    public override void afterDelete() {}
    public override void afterUndelete() {}

    /**
     * If a new Pokemon is created, make a new Trainer Pokemon record for every trainer
     * @param   List<Pokemon__c>. All new pokemon records
     */
    @TestVisible
    private void createNewTrainerPokemonLink(List<Pokemon__c> newPkmn) {
        List<Trainer_Pokemon__c> newLinkRecords = new List<Trainer_Pokemon__c>();
        List<Trainer__c> allTrainers = [SELECT Id FROM Trainer__c];

        for (Pokemon__c pkmn : newPkmn) {
            for (Trainer__c theTrainer : allTrainers) {
                Trainer_Pokemon__c newLink = new Trainer_Pokemon__c();
                newLink.Pokemon__c  = pkmn.Id;
                newLink.Trainer__c  = theTrainer.Id;
                newLink.Acquired__c = false;
                newLinkRecords.add(newLink);
            }
        }

        try {
            insert newLinkRecords;
            System.debug('New link records were successfully inserted.');
            System.debug(newLinkRecords);
        } catch (Exception e) {
            System.debug('Couldn\'t insert the new link records because');
            System.debug(e.getMessage());
        }
    }

}