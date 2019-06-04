public with sharing class FitbitReviewController {

    public String returnValues { get; set; }

    public FitbitReviewController() {

        returnValues = 'Default';
        // returnValues = JSON.serializePretty(returnValues);

    }
}