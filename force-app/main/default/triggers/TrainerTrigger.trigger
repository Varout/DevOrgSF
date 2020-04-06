/**
 * Class: TrainerTrigger.trigger
 * Runs all triggers before and after: insert, update, delete, and undelete
 */
trigger TrainerTrigger on Trainer__c (before insert, before update, before delete,
                                      after insert, after update, after delete, after undelete) {
    new TrainerTriggerHandler().run();
}