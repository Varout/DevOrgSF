/**
 * This TriggerHandler is to serve as an example
 * Internal functions can be public or private.  Prefer to keep as private and
 * make them @TestVisible
 */
public with sharing class TriggerExampleHandler extends TriggerHandler{

    public override void beforeInsert() {
        exampleBeforeFunction();
        exampleBeforeFunctionParam(Trigger.new);
    }
    public override void beforeUpdate() {}
    public override void beforeDelete() {}

    public override void afterInsert() {}
    public override void afterUpdate() {}
    public override void afterDelete() {}
    public override void afterUndelete() {}

    @TestVisible
    private void exampleBeforeFunction() {
        List<Account> triggerAccountsNew = (List<Account>) Trigger.new;
        Map<Id, Account> triggerAccountsNewMap = (Map<Id, Account>) Trigger.newMap;
    }

    @TestVisible
    private void exampleAfterFunction() {
        List<Account> triggerAccountsNew = (List<Account>) Trigger.new;
        List<Account> triggerAccountsOld = (List<Account>) Trigger.old;
        Map<Id, Account> triggerAccountsNewMap = (Map<Id, Account>) Trigger.newMap;
        Map<Id, Account> triggerAccountsOldMap = (Map<Id, Account>) Trigger.oldMap;
    }

    @TestVisible
    private void exampleBeforeFunctionParam(List<Account> triggerAccounts) {
        //  Do this with passed information
    }

}