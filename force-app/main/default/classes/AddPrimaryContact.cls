/**
 * 
 */
public class AddPrimaryContact implements Queueable {

    private String theState;
    private Contact theContact;

    //  Setup
    public AddPrimaryContact(Contact contacts, String state) {
        this.theState = state;
        this.theContact = contacts;
    }

    //  Do the thing
    public void execute(QueueableContext context) {
        List<Account> theAccounts = [
            SELECT Id, BillingState
            FROM Account
            WHERE BillingState = :this.theState
            LIMIT 200
        ];
        
        List<Contact> newContacts = new List<Contact>();
        for (Account a : theAccounts) {
            Contact tempContact = this.theContact.clone();
            tempContact.AccountId = a.Id;
            newContacts.add(tempContact);
        }

        insert newContacts;
    }
}
