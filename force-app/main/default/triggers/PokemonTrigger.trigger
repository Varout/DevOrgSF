/**
 * Class: PokemonTrigger.trigger
 */
trigger PokemonTrigger on Pokemon__c (before insert, before update, before delete,
                                      after insert, after update, after delete, after undelete) {
    new PokemonTriggerHandler().run();
}