/**
 * Class: ScheduleExample.cls
 * Test:  ScheduleEampleTest.cls
 * @desc: An example of a scheduled job
 */
global class ScheduleExample implements Schedulable{

    // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
    public static String JOB_CRON = '0 0 12 ? * WED *';
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

    }

}