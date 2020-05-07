/**
 * 
 */
global class ScheduleExample implements Schedulable{

    public static final String JOB_NAME = 'Schedule Job Example';
    public static final String JOB_CRON = '';

    public static void schedule() {

    }

    global void execute(SchedulableContext sc) {
        System.debug('Hello world');
    }

}
