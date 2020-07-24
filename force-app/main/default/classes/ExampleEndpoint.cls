@RestResource(urlMapping='/example/export')
global class ExampleEndpoint {

    class ExampleEndpointException extends Exception{}

    @HttpGet
    global static void handleGet() {
        RestResponse res = RestContext.response;
        try {
            //  Success
            res.StatusCode = 200;
            res.responseBody = Blob.valueOf(doSomeThing());
        } catch (Exception e) {
            //  Fail
            res.statusCode = 500;
            res.responseBody = Blob.valueOf(e.getMessage());
        }
    }

    //  Extra code related
    private static String doSomeThing() {
        return 'Hello world';
    }
}
