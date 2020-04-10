/**
 * Class: TrainerTriggerHandler.cls
 * Test: TrainerTriggerHandlerTest.cls
 */
public class TrainerTriggerHandler extends TriggerHandler{

    // public override void beforeInsert() {}
    // public override void beforeUpdate() {}
    // public override void beforeDelete() {}

    public override void afterInsert() {
        this.initialSetupForTrainerRecord(Trigger.new);
    }

    // public override void afterUpdate() {}
    // public override void afterDelete() {}
    // public override void afterUndelete() {}

    /**
     * Has to be run after insert so the Trainer records have an Id. Sets up an record to link
     * each existing pokemon record to the trainer with a Trainer Pokemon record
     * @param   List<Trainer__c>. List of new trainers after they've been inserted
     */
    @TestVisible
    private void initialSetupForTrainerRecord(List<Trainer__c> newTrainers) {
        List<Trainer_Pokemon__c> newLinkRecords = new List<Trainer_Pokemon__c>();
        List<Pokemon__c> allPokemon = [SELECT Id FROM Pokemon__c];
        if (allPokemon.isEmpty()) { return; }

        for (Trainer__c theTrainer : newTrainers) {
            for (Pokemon__c pkm : allPokemon) {
                Trainer_Pokemon__c linkRecord = new Trainer_Pokemon__c();
                linkRecord.Trainer__c  = theTrainer.Id;
                linkRecord.Pokemon__c  = pkm.Id;
                linkRecord.Acquired__c = false;
                newLinkRecords.add(linkRecord);
            }
        }

        try {
            insert newLinkRecords;
            // System.debug('New records successfully inserted for new trainers:');
            // System.debug(newTrainers);
        } catch (Exception e) {
            System.debug('New records couldn\'t be inserted for new trainers');
            System.debug(e.getMessage());
        }
    }

}