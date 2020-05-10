global class DailyLeadProcessor implements Schedulable{

    public static String JOB_NAME { get; private set; }
    public static String JOB_CRON { get; private set; }
    static {
        JOB_NAME = 'Schedule: DailyLeadProcessor';
        JOB_CRON = '0 0 12 * * ? *';
    }

    public static void schedule() {
        System.schedule(JOB_NAME, JOB_CRON, new DailyLeadProcessor());
    }

    global void execute(SchedulableContext ctx) {
        List<Lead> theLeads = [SELECT Id FROM Lead WHERE LeadSource = null LIMIT 200];
        for (Lead l : theLeads) {
            l.LeadSource = 'Dreamforce';
        }
        System.debug('Updating leads');
        update theLeads;
    }

}