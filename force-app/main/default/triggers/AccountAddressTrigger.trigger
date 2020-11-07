/**
 * Trailhead Training
 */
trigger AccountAddressTrigger on Account (before insert,
                                          before update) {

//     System.debug('Triggered on account');
//     for (Account a : Trigger.new) {
//         if (a.Match_Billing_Address__c && String.isNotBlank(a.BillingPostalCode)) {
//             a.ShippingPostalCode = a.BillingPostalCode;
//         }
//         System.debug('Match: ' + a.Match_Billing_Address__c + ', not blank: ' + String.isNotBlank(a.BillingPostalCode));
//     }


}