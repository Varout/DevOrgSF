public class CalloutController {
// Unique label corresponding to the continuation
    public String requestLabel;
    // Result of callout
    public String result {get;set;}

    public Object startRequest() {
        //this part up here is common to both the callout 
        //and continuations approaches
        String sessionId = UserInfo.getSessionId();

        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + sessionID);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');

        //this doesn't actually work because we don't have a real web service to call
        //but you get the idea.
        req.setEndpoint('test_endpoint');

        req.setMethod('GET');

        // //Here's how it works with a callout
        // Http h = new Http();
        // HttpResponse res = h.send(req);
        // result = res.getBody();
        // return null;
        // //and that is all. This works fine until the service is too slow and lots of people use it.

        //  Here's how it works with a continuation
        //  Continuation(40) constructs a continuation with a timeout of 40 seconds
        //  The max value this can be is 120 seconds
        //  Link: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_System_Continuation.htm
        Continuation con = new Continuation(40);
        // con.ContinuationMethod = 'handleCallback';
        con.ContinuationMethod = 'processResponse';
        this.requestLabel = con.addHttpRequest(req);
        return con;
    }

    public Object processResponse() {
        HttpResponse res = Continuation.getResponse(this.requestLabel);
        this.result = res.getBody();
        //  Return null to re-render the VF Page
        return null;
    }

    // //  Here is the callback that waits for a response before continuing
    // public Object handleCallback() {
    //     HttpResponse res = Continuation.getResponse(this.requestLabel);
    //     return processResponse(res);
    // }

    // //  Callback method is only needed for continuations
    // public Object processResponse(HttpResponse res) {
    //     result = res.getBody();

    //     //Return null to re-render the original Visualforce Page
    //     return null;
    // }
}