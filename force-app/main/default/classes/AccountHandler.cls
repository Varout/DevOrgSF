public with sharing class AccountHandler {
    public AccountHandler() {

    }

    public static void insertAccount(Integer numberOfNewAccounts) {
        List<Account> addAccounts = new List<Account>();
        Integer n = 1;
        while (n < 4) {
            Account newAccount = new Account();
            newAccount.Name = 'Acme Inc ' + String.valueOf(n);
            newAccount.AccountNumber = 'AOOO' + String.valueOf(n);
            addAccounts.add(newAccount);
            n += 1;
            System.debug(newAccount);
        }
        insert addAccounts;
    }

}
