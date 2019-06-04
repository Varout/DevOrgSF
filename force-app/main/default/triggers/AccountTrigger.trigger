trigger AccountTrigger on Account (before insert, before update, before delete
                                   //after insert,  after update,  after delete,  after undelete
                                  ) {
/*
	//	Commented out for Trailhead challenge
    if (Trigger.isAfter && Trigger.isInsert) {
        AccountHandler.CreateNewOpportunity(Trigger.New);
    }
*/
	if (Trigger.isBefore && Trigger.isInsert) {
		AccountTriggerHandler.CreateAccounts(Trigger.New);
	}
}