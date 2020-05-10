/**
 * Class: EmailManager.cls
 * Test:  EmailManagerTest.cls
 * @desc: Used to send emals from the org wide email address
 */
public with sharing class EmailManager {
    
    /**
     * Constructs an email message and sends it from the OrgWideEmailAddress
     * @param   String. The email address of the recipient
     * @param   String. The email's subject
     * @param   String. The body of the email
     * @return  Boolean. True if the email sent correctly, otherwise false
     */
    public static Boolean sendMail(String address, String subject, String body) {
        // Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String>{ address };
        mail.setToAddresses(toAddresses);
        mail.setOrgWideEmailAddressId( EmailManager.getOrgWideEmailAddressId() );
        mail.setSubject(subject);
        mail.setPlainTextBody(body);

        // Pass this email message to the built-in sendEmail method of the Messaging class
        List<Messaging.SendEmailResult> results = Messaging.sendEmail( new List<Messaging.SingleEmailMessage>{ mail } );
        // Call a helper method to inspect the returned results.
        return EmailManager.inspectResults(results);
    }

    /**
     * Helper method. Checks to see if the emails successfully sent
     * @param   List<Messaging.SendEmailResult>. A list of results from Messaging.sendEmail()
     * @return  Boolean. True if the emails sent successfully, otherwise false
     */
    @TestVisible
    private static Boolean inspectResults(List<Messaging.SendEmailResult> results) {
        Boolean sendResult = true;

        // Messaging.SendEmail() returns an array of result objects. Iterate through the list to inspect results.
        // In this class, the methods send only one email, so we should have only one result.
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            } else {
                sendResult = false;
                System.debug('The following errors occurred: ' + res.getErrors());                 
            }
        }

        return sendResult;
    }

    /**
     * Gets the Id for the OrgWideEmailAddress. Assumes there's only one. If there is more than one,
     * it returns the first in the list
     * @return  Id. The Id of a value OrgWideEmailAddress
     */
    @TestVisible
    private static Id getOrgWideEmailAddressId() {
        Id oweaId = null;
        List<OrgWideEmailAddress> owea = [
            SELECT Id
            FROM OrgWideEmailAddress
        ];

        if (!owea.isEmpty()) {
            oweaId = owea[0].Id;
        }

        return oweaId;
    }
}