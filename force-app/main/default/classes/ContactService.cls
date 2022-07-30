public with sharing class ContactService {

    public final static Id TENANT_RECORD_TYPE_ID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Tenant').getRecordTypeId();

    /**
     * Method validates tenant before insert to Contact.
     * 
     * @param newList new inserted contacts
     * @author belekomurzakov
     */
    public static void validateTenant(List<Contact> newList) {
        for (Contact contact : newList) {
            if (contact.RecordTypeId != TENANT_RECORD_TYPE_ID) {
                continue;
            }
            if (contact.Credit_Score__c == null || contact.Credit_Score__c < 629) {
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

    /**
     * Method validates Phone before insert.
     * 
     * @param newList new inserted contacts
     * @author belekomurzakov
     */
    public static void validatePhone(List<Contact> newList) {
        for (Contact con : newList) {
            if (String.isBlank(con.Phone)) {
                continue;
            }
            try {
                Integer x = Integer.valueOf(con.Phone);
            } catch (Exception e) {
                con.addError('Phone can be only numbers');
            }
        }
    }

    /**
     * Method sends Welcome Email to Newly Created Customer.
     * 
     * @param newList new inserted contacts
     * @author kushtar
     */
    public static void sendWelcomeEmail(List<Contact> newList) {
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();

        for (Contact contact : newList) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = new String[]{contact.Email};
            message.plainTextBody = 'Hello, ' + contact.LastName + ' for your interest in our properties. Hope you will find what you like.';
            messages.add(message);

            try {
                Messaging.sendEmail(messages);
            } catch (Exception e) {
                //do nothing.
            }
        }
    }
}
