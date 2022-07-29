public with sharing class EmailService {
 
    public static void send(String address){
         // get an email template
    EmailTemplate tpl = (EmailTemplate)[select Id, Subject, Body  FROM EmailTemplate 
    WHERE Name = 'Customer Feedback Survey Email' limit 1];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTemplateId(tpl.Id);
        message.toAddresses = new String[]{address};
        message.setHtmlBody(tpl.Body);
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
        Messaging.sendEmail(messages);
    } 
}