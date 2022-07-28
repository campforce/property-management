public with sharing class EmailService {
 
    public static void send(String address){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[]{address};
        message.plainTextBody = 'Hello, we kindly ask you to fill out a short survey to give us a feedback.';
        message.setHtmlBody('To start the survey <a href=https://forms.gle/hbH3BnpSqZmjiaV28'+'>click here.</a>');
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
        Messaging.sendEmail(messages);
    } 
}