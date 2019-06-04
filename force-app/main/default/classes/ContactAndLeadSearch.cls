public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String searchParam) {
        
        List<List<SObject>> theResults = [
            FIND :searchParam 
            IN NAME FIELDS 
            RETURNING Lead(FirstName, LastName), Contact(FirstName, LastName)
        ];
        
        return theResults;
    }
}