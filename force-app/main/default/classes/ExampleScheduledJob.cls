/**
 * Class: ExampleScheduledJob.cls
 * Test:  ExampleScheduledJobTest.cls
 * @desc: An example of a scheduled job. Salesforce documentation can be found at:
 *        https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_scheduled
 *        Includes an example of how to run a Batchable Job from a Scheduled Job
 */
global class ExampleScheduledJob implements Schedulable {
    // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
    public static String JOB_CRON = '0 0 12 ? * WED *';     //  Run every Wednesday at 12:00
    public static String JOB_NAME = 'Schedule Job Example';

    /**
     * Public static scheduler so that we can schedule the job with ease
     * If running a test, appeands ' Test' to the end of the job name
     * If the scheduled job already exists, don't schedule a new job
     */
    public static void schedule() {
        if (Test.isRunningTest()) {
            JOB_NAME += ' Test';
        }
        String jobID = System.schedule(JOB_NAME, JOB_CRON, new ExampleScheduledJob());
    }

    /**
     * Do this when running the scheduled job
     * Tidier to reference a logic or utility class
     */
    // global void execute(SchedulableContext sc) {
    //     System.debug('Hello world');
    // }

    /**
     * Example of running Batchable code
     */
    global void execute(SchedulableContext sc) {
        ExampleBatchJob batchEx = new ExampleBatchJob();
        // Id batchId = Database.executeBatch(batchEx);
        Id batchId = Database.executeBatch(batchEx, 100);

        AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId];
    }

/*
    Useful SOQL Queries

    Use CronJobDetail relationship to get the job’s name and type.
    SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType FROM CronTrigger ORDER BY CreatedDate ASC LIMIT 10

    You can also query CronJobDetail directly to get the job’s name and type.
    SELECT Id, Name, JobType FROM CronJobDetail WHERE Id = 'someId'

    To get total count of all Apex scheduled jobs (except other scheduled job types), run the following query.
    SELECT COUNT() FROM CronTrigger WHERE CronJobDetail.JobType = '7'

    Data Export (0)
    Dashboard Refresh (3)
    Analytic Snapshot (4)
    Scheduled Apex (7)
    Report Run (8)
    Batch Job (9)
 */
}
