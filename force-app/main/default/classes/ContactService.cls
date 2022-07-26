public with sharing class ContactService {

    /**
     * Method validates tenant before insert to Contact.
     * 
     * @param newList new inserted contacts
     * @author belekomurzakov
     */
    public static void validateTenant(List<Contact> newList) {
        for(Contact contact : newList) {
            if (contact.Credit_Score__c == null ||contact.Credit_Score__c < 629) {
                contact.addError('This tenant has too low credit score. It should be more than 629.');
            }
            if (String.isEmpty(contact.Occupation__c) || contact.Occupation__c == 'Student') {
                contact.addError('This tenant is Student or unemployed.');
            }

            if (contact.Birthdate == null || Date.today().year() - contact.Birthdate.year() < 18) {
                contact.addError('This tenant is too young to deal with.');
            }  
            if (String.isBlank(contact.Email)) {
                contact.addError('Provide your email address.');
            }           
        }
    }

    //This method sends Welcome Email to Newly Created Customer.
    public static void sendWelcomeEmail(List<Contact> newList){
        for (Contact contact: newList){
            try {
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toAddresses = new String[]{contact.Email};
                message.plainTextBody = 'Hello, ' + contact.Lastname + ' for your interest in our properties. Hope you will find what you like.';
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

            } catch (Exception e){
                //do nothing.
            }
        }
       
    }
}
