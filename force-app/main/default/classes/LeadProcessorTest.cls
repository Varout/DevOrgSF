/**
 * 
 */@istest
 private class LeadProcessorTest {
    
    @isTest
    static void testOne() {
        List<Lead> testLeads = new List<Lead>();
        while (testLeads.size() < 200) {
            Lead l = new Lead();
            l.LastName = 'test' + String.valueOf(testLeads.size() + 1);
            l.Company = 'Testing LLC';
            l.LeadSource = 'Email';
            testLeads.add(l);
        }
        System.debug(testLeads.size());
        try {
            insert testLeads;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }

        LeadProcessor b = new LeadProcessor();
        Test.startTest();
        Id batchId = Database.executeBatch(b);
        // Id batchId = Database.executeBatch(b, 10);   //  Limits records processed at a time by 10
        Test.stopTest();

        System.assertEquals(200, [SELECT Count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }

}
