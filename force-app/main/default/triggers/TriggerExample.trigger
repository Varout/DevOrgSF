/**
 * SObject: Account is a place holder
 * This is to serve as an example for a trigger
 */
trigger TriggerExample on Account (before insert, before update, before delete,
                                   after insert, after update, after delete, after undelete) {
    new TriggerExampleHandler().run();
}