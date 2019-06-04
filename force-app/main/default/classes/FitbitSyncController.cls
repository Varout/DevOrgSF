/**
 * @Name: FitbitSyncController.cls
 * @Created: March 2019
 * @Author: Jason Auger
 * @Description: Contains methods to retrieve data from Fitbit API services
 */
public with sharing class FitbitSyncController {

    private String API_KEY { get; set; }
    private String URL_ENDPOINT { get; set; }

    public FitbitSyncController() {
        API_KEY = '';
        URL_ENDPOINT = '';
    }

    public void mainProcessFunction() {
        mainProcessFunction(null, null);
    }

    public void mainProcessFunction(Date theDate) {
        mainProcessFunction(theDate, null);
    }

    public void mainProcessFunction(Date startDate, Date endDate) {
        //  Setup
        List<String> theDataToStore = new List<String>();

        //  Check if data for the given date(s) already exists.


        //  Get the data
        if (startDate == null) {
            theDataTostore.add(getInfotoday());
            // theDataToStore.add(getFitbitInfo());
        } else if (startDate != null && endDate == null) {
            theDataTostore.add(getInfoDate(startDate));
            // theDataToStore.add(getFitbitInfo(startDate));
        } else if (startDate != null && endDate != null) {
            theDataTostore.addAll(getInfoDateRange(startDate, endDate));
            // theDataToStore.add(getFitbitInfo(startDate, endDate));
        } else {
            return;
        }

        //  Process and store the data
        storeData(theDataToStore);
    }

    /**
     * @name: getInfoToday
     * @author: Jason Auger
     * @date: March 2019
     * @description: Gets all known information about the current day
     * @returns: Type: String
     */
    // public String getFitbitInfo() {
    @TestVisible
    private String getInfoToday() {
        //  TODO: Rename to getFitbitInfo
        return getInfoDate(Date.today());
    }

    /**
     * @name: getInfoDate
     * @author: Jason Auger
     * @date: March 2019
     * @description: Gets all known information about the provided date.
     * @input:
     *      - 1) Type: Date.  The date for which to retrieve the data.
     * @returns: Type: String
     */
    // public String getFitbitInfo(Date dateToQuery) {
    @TestVisible
    private String getInfoDate(Date dateToQuery) {
        //  TODO: Rename to getFitbitInfo
        return null;
    }

    /**
     * @name: getInfoDateRange
     * @author: Jason Auger
     * @date: March 2019
     * @description: Gets all information given a certain date range
     * @input:
     *      - 1) Type: Date. The date to start getting data at.  Inclusive.
     *      - 2) Type: Date. The date to end getting data from.  Inclusive.
     * @returns: Type: List<String>. Data in JSON format as an array/list entry 
     *           for each date in the date range
     */
    // public String getFitbitInfo(Date startDate, Date endDate) {
    @TestVisible
    private List<String> getInfoDateRange(Date startDate, Date endDate) {
        //  TODO: Rename to getFitbitInfo
        return null;
    }

    /**
     * @name: storeData
     * @author: Jason Auger
     * @date: March 2019
     * @description: Retrieves requested data and stores it in the appropriate
     *               objects in Salesforce against the correct user(s).
     * @input: The data as a List<String> where the string is JSON
     */
    @TestVisible
    private void storeData(List<String> theJsonData) {
        //  Do we want to check for existing information first?
        List<Fitbit_Month__c> fitbitMonths = new List<Fitbit_Month__c>();
        List<Fitbit_Day__c> fitbitDays = new List<Fitbit_Day__c>();

        try {
            //  TODO:  Need to store error messages after insert.
            Database.insert(fitbitMonths, false);
            Database.insert(fitbitDays, false);

            //  System.debug(Output error message for any months/days that couldn't be inserted)
        } catch (Exception e) {
            System.debug('FitbitSyncController: Could not insert objects. Reason: ' + e.getMessage());
        }
    }

    /**
     *
     */
    public void httpAPICallout() {
    // public void httpAPICallout(Date startDate, Date endDate) {

        //  Example code
        // Http http = new Http();
        // HttpRequest request = new HttpRequest();
        // request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        // request.setMethod('GET');
        // HttpResponse response = http.send(request);
        // // If the request is successful, parse the JSON response.
        // if (response.getStatusCode() == 200) {
        //     // Deserialize the JSON string into collections of primitive data types.
        //     Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        //     // Cast the values in the 'animals' key as a list
        //     List<Object> animals = (List<Object>) results.get('animals');
        //     System.debug('Received the following animals:');
        //     for (Object animal: animals) {
        //         System.debug(animal);
        //     }
        // }

        //  Construct the endpoint string
        String endpointString = URL_ENDPOINT + '';
        //  Construct the HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointString);
        request.setMethod('GET');
        //  Send request and store response
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            List<String> results = (List<String>) JSON.deserializeUntyped(response.getBody());
            System.debug('Received the following data:');
            for (String result: results) {
                System.debug(result);
            }
        }
    }

    /**
     * @name: checkDateRange
     * @author: Jason Auger
     * @date: March 2019
     * @description:
     * @input:
     *      - 1) Type: Date. The start date to check if data already exists.  Inclusive.
     *      - 2) Type: Date. The end date to check if data already exists.  Inclusive.
     * @returns: Type: Map<Id, List<Date>>
     */
    @TestVisible
    private Map<Id, List<Date>> checkDateRange(Date startDate, Date endDate) {
        Map<Id, List<Date>> mapOfUserIdDates = new Map<Id, List<Date>>();
        return mapOfUserIdDates;
    }

}