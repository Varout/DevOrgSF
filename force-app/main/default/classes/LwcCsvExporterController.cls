/**
 * Class: LwcCsvExporterController.cls
 * Test:  LwcCsvExporterControllerTest.cls
 * @desc: Controller for the csvExporter Lightning Web Component
 */
public with sharing class LwcCsvExporterController {
    public LwcCsvExporterController() {

    }

    @AuraEnabled
    public static String getOrgSObjectNames() {
        try {
            return JSON.serialize(SObjectUtil.getSetOfOrgSObjects());
        } catch (Exception e) {
            throw new AuraHandledException('An error occurred retrieving all SObject names.');
        }
    }
}

/*

    populateSObjectPicklist() {
        let returnPicklist = Array();
        this.jsonSObjects.forEach(element => {
            returnPicklist.push(
                { label: element, value: element }
            );
        });
        return returnPicklist;
    }

    */