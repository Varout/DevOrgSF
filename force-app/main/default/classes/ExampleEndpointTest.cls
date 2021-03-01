/**
 * Example from: https://www.thinkaholics.com/salesforce/a-simple-apex-test-class-for-rest-api/
 */
@isTest
private class ExampleEndpointTest {

    @TestSetup
    static void makeData() {
        //  Necessary test data setup
    }

    /**
     * Example code of a successful hit to the endpoint, data returned
     */
    @isTest
    static void exampleTestSuccess() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/example/export';
        req.httpMethod = 'GET';

        // req.addParameter(name, value);
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ExampleEndpoint.handleGet();
        Test.stopTest();

        String testResponseBlob = res.responseBody.toString();
        Integer testResponseCode = res.statusCode;
    }


    /**
     * Example code of a successful hit to the endpoint, but error returned
     * NB: Currently no way to force with example code
     */
    static void exampleTestSuccessFail() {

    }
}