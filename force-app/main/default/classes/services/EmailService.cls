public with sharing class EmailService {

    public static void send(String address, Id targetObjectId) {
        EmailTemplate tpl = (EmailTemplate) [SELECT Id, Subject, Body FROM EmailTemplate WHERE Name = 'Customer Feedback Survey Email' LIMIT 1];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTemplateId(tpl.Id);
        message.setTargetObjectId(targetObjectId);
        message.toAddresses = new String[]{address};
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
        Messaging.sendEmail(messages);
    }
}