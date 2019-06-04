public class AccountUtils {
	
    //	Return a list of Accounts based on the Billing State string that is passed.
    //	Will return an empty list if no accounts match the billing state string.
    public static List<Account> accountsByState(String selectedBillingState) {
        List<Account> returnedAccounts = new List<Account>();
        
        returnedAccounts = [
            SELECT Id, Name
            FROM   Account
            WHERE  BillingState = :selectedBillingState
        ];
        
        return returnedAccounts;
    }
    
}