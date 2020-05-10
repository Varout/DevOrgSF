@isTest
private class DailyLeadProcessorTest {
    @TestSetup
    static void makeData() {
        List<Lead> testLeads = new List<Lead>();
        while (testLeads.size() < 200) {
            Lead testLead = new Lead();
            testLead.LastName = 'Montoya ' + String.valueOf(Math.random());
            testLead.LeadSource = null;
            testLead.Company = 'Testing LLC';
            testLeads.add(testLead);
        }
        insert testLeads;
    }

    @isTest
    static void testSchedule() {
        DailyLeadProcessor.schedule();

        System.assertEquals(1, [SELECT Count() FROM CronJobDetail WHERE Name = :DailyLeadProcessor.JOB_NAME]);
    }

    @isTest
    static void testLeadProcess() {
        System.assertEquals(200, [SELECT Count() FROM Lead]);

        Test.startTest();
        System.schedule(DailyLeadProcessor.JOB_NAME, DailyLeadProcessor.JOB_CRON, new DailyLeadProcessor());
        Test.stopTest();

        System.assertEquals(1, [SELECT Count() FROM CronJobDetail WHERE Name = :DailyLeadProcessor.JOB_NAME]);
        System.assertEquals(200, [SELECT Count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}
