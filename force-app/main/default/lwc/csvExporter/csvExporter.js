import { LightningElement, api, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
//  import functionName from '@salesforce/apex/ApexController.functionName';
import getOrgSObjectNames from '@salesforce/apex/LwcCsvExporterController.getOrgSObjectNames';

export default class CsvExporter extends LightningElement {

    //  For local LWC server: 
    //  sfdx plugins:install @salesforce/lwc-dev-server

    //  Constants
    //  EXAMPLE_CONSTANT = 'something';

    //  Declare globals
    //  aVariable;
    jsonSObjects;
    sObjOptions;
    sobjectSelection;

    //  Constructor
    async connectedCallback() {
        // this.aVariable = null;

        //  Populate SObject list. Should be returned as JSON strong
        //  https://developer.salesforce.com/docs/component-library/bundle/lightning-combobox/example
        try {
            this.jsonSObjects = JSON.parse(await getOrgSObjectNames());
            // console.warn(this.jsonSObjects);
            if (!this.jsonSObjects) {
                //  Nothing was returned, something went wrong that wasn't caught by the Apex controller
                alert('Something went wrong. No SObject names were returned.');
                return;
            }
            this.populateSObjectPicklist();
        } catch (error) {
            alert(error.body.message);
            return;
        }

        // console.warn(this.populateSObjectPicklist());
    }


    populateSObjectPicklist() {
        this.sObjOptions = Array();
        // console.warn(this.jsonSObjects.length);
        for (var i = 0; i < this.jsonSObjects.length; i++) {
            console.log(this.jsonSObjects[i]);
            this.sObjOptions.push(
                { label: this.jsonSObjects[i], value: this.jsonSObjects[i] }
            );
        }
        console.warn('complete');
    }


    handleSObjPicklistChange() {
        this.sobjectSelection = event.detail.value;
    }

    //  https://www.w3schools.com/howto/howto_js_autocomplete.asp
    handleSObjTextChange() {
        console.log('Input box change');
    }


    //  Example local function
    handleLocalFunction() {
        //  Do what's needed
    }


/*  //  Example function with callout to apex
    async handleFunctionWithApexCallout() {
        //  stuff and things

        let returnContent = null;
        try {
            returnContent = await functionName({
                firstFunctionParam: this.localParam,
                secondFunctionParam: this.localParam
            })
        } catch (error) {
            alert(error.body.message);
            return;
        }
    } */

}