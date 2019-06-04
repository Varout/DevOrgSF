/**
 * Books4EveryoneHomeController.cls
 * Controller used for Trailhead Books4Everyone UnmanagedPackage.
 * 
 * @authors: Trailhead, Jason (Trineo)
 * @date: February 2019
 */
public with sharing class Books4EveryoneHomeController {
    /**
     * Get a list of books and their description
     */
	@AuraEnabled
	public static List<Book__c> getBooks(){
    	return [
        	SELECT Id, Name, Description__c
        	FROM Book__c
    	];
    }

    /**
     * Get a list of books with their author and a description
     * of the book
     */
    @AuraEnabled
    public static List<Book__c> getBooksAndAuthor() {
        return [
            SELECT Id, Name, Description__c, Author__r.Name
            FROM Book__c
        ];
    }
    
    /**
     * Get a list of book recommendation values with book name and review. 
     */
    @AuraEnabled
    public static List<Recommendation__c> getBookRecommendations(){
    	return [
            SELECT Name, Review__c, Rating__c, Book__r.Name, Book__r.Author__r.Name
        	FROM Recommendation__c
        	WHERE Book__c != null
        ];
    }
    
    /**
     * Get a list of books that do not have authors listed in our
     * database
     */
    @AuraEnabled
    public static List<Book__c> getBooksWithoutAuthors(){
        return [
            SELECT Name
            FROM Book__c
            WHERE Author__c = null
        ];
    }
}