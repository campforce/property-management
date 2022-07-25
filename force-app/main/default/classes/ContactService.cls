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
        }
    }
}
