public with sharing class AccountHandler {
    
    //	Creates an account with a given account name and tries to insert it to the database.
    //	Returns null if the account couldn't be inserted, and debug log shows error.
    public static Account insertNewAccount(String accountName) {
        Account newAccount = new Account();
        newAccount.Name = accountName;
        
        try {
            insert newAccount;
            //System.debug('Account successsfully inserted.');
            //System.debug(newAccount);
        } catch (DMLException e) {
            newAccount = null;
            System.debug('DML Exception: Account not inserted. ' + e.getCause());
            //System.debug(newAccount);
        }

        return newAccount;
    }
    
    //	Creates a new opportunity for each account passed (Trailhead code, not mine)
    //	I don't know why you would insert each opportunity separately. :(
/*    public static void CreateNewOpportunity(List<Account> accts) {
        for (Account a : accts) {
            Opportunity opp = new Opportunity();
            opp.Name = a.Name + ' Opportunity';
            opp.AccountId = a.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.Today().addMonths(1);
            insert opp;
        }
    }	*/
    
    //	Method does the same as above, but more efficiently.
    //	Trailhead fixed it later on in the module! :)
    public static void CreateNewOpportunity(List<Account> accts) {
        List<Opportunity> opps = new List<Opportunity>();
        for (Account a : accts) {
            Opportunity opp = new Opportunity();
            opp.Name = a.Name + ' Opportunity';
            opp.AccountId = a.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.Today().addMonths(1);
            opps.add(opp);
        }
        if (opps.size() > 0) {
            insert opps;
        }
    }
    
    
}