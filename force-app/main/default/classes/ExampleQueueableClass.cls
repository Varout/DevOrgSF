/**
 * Class: ExampleQueueableClass.cls
 * Test:  ExampleQueueableClassTest.cls
 * @desc: Logic for queueable. How to run example code in: ExampleQueueableClassRun.cls
 */
public class ExampleQueueableClass implements Queueable{

    private Id parentId;
    private List<Account> accounts;

    public ExampleQueueableClass(List<Account> accs, Id parAccId) {
        //  Setup global variables
        this.parentId = parAccId;
        this.accounts = accs;
    }

    public void execute(QueueableContext context) {
        for (Account a : this.accounts) {
            a.ParentId = this.parentId;
            //  Do more if needed
        }
        update this.accounts;
    }
}