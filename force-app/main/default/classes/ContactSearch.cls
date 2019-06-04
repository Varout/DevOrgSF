public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        List<Contact> theContactList = new List<Contact>();
        
        theContactList = [
            SELECT Id, FirstName, LastName
            FROM Contact
            WHERE LastName = :lastName
              AND MailingPostalCode = :postalCode
        ];
        
        return theContactList;
    }
}