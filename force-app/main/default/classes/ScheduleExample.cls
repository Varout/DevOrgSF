/**
 * Class: ScheduleExample.cls
 * Test:  ScheduleEampleTest.cls
 * @desc: An example of a scheduled job. Salesforce documentation can be found at:
 *        https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_scheduled
 */
global class ScheduleExample implements Schedulable{

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
        String jobID = System.schedule(JOB_NAME, JOB_CRON, new ScheduleExample());
    }

    /**
     * Do this when running the scheduled job
     */
    // global void execute(SchedulableContext sc) {
    //     System.debug('Hello world');
    // }

    /**
     * Example of running Batchable code
     */
    global void execute(SchedulableContext sc) {
        BatchExample batchEx = new BatchExample();
        // Id batchId = Database.executeBatch(batchEx);
        Id batchId = Database.executeBatch(batchEx, 100);

        AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId];
    }

}