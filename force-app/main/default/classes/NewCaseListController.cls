/**
 * Class Name: NewCaseListController
 * Description: Trailhead challenge class for VF page: NewCastList
 * Link: https://trailhead.salesforce.com/content/learn/modules/visualforce_fundamentals/visualforce_custom_controllers
 */
public with sharing class NewCaseListController {

    public List<Case> newCases  { get; set; }
    
    public NewCaseListController() {
        getNewCases();
    }
    
    public List<Case> getNewCases() {
        //theCasesToReturn = new List<Case>();
        
        newCases  = [
            SELECT Id, CaseNumber
            FROM Case
            WHERE status = 'New'
        ];
        
//        for (Case c : theCasesToReturn) {
//            System.debug(c);
//        }
        
        return newCases;
    }
    
}