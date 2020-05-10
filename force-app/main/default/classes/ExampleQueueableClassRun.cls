/**
 * 
 */
public class ExampleQueueableClassRun {
    public ExampleQueueableClassRun() {
        ExampleQueueableClassRun.doTheThing();
    }

    //  Information about running the Queueable job
    public static void doTheThing() {
        // find all accounts in ‘NY’
        List<Account> accounts = [select id from account where billingstate = 'NY'];
        // find a specific parent account for all records
        Id parentId = [select id from account where name = 'ACME Corp'][0].Id;
        // instantiate a new instance of the Queueable class
        ExampleQueueableClass updateJob = new ExampleQueueableClass(accounts, parentId);
        // enqueue the job for processing
        ID jobID = System.enqueueJob(updateJob);
    }

    //  To get information about the job
    public static AsyncApexJob getStatusOfJob(Id jobId) {
        return [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobId];
    }
}