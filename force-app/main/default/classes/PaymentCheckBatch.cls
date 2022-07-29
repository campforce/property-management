public with sharing class PaymentCheckBatch implements Database.Batchable<SObject>, Schedulable {
    public void execute(System.SchedulableContext sc) {
        PaymentCheckBatch batch = new PaymentCheckBatch();
        Database.executeBatch(batch, 200);
    }
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Is_Rented__c, Is_Paid__c, Tenant__r.Email FROM Property__c Where Is_Rented__c=true ANd Is_Paid__c=false');
    }
    public void execute(Database.BatchableContext bc, List<Property__c> properties) {
        Map<Id, Property__c> propertyMap = new Map<Id, Property__c>(properties);
        List<Payments__c> paymentList = [SELECT Tenants__r.Email, Tenants__r.LastName, Property__c FROM Payments__c WHERE Property__c IN: propertyMap.keySet() AND Date__c = THIS_MONTH];
        
        // Payments for July
        // IN paymentList -> isPaid = false -> check isPaid to TRUE
        // NOT IN paymentList -> notifying
		
        
        // Payments for July
        // IN paymentList -> isPaid = false -> check isPaid to TRUE
        // NOT IN paymentList -> notifying
        
        
        List<Property__c> propertiesToCheck = new List<Property__c>();
        List<Property__c> propertiesToNotify = new List<Property__c>();
        Set<Id> propertyIds = new Set<Id>();
        
        if(paymentList.size() > 0) { 
            for(payments__c p : paymentList) {
                propertyIds.add(p.Property__c);
            }
        }
        
        for(Property__c pr : properties) {
            if(propertyIds.size() > 0 && propertyIds.contains(pr.Id)) {
                propertiesToCheck.add(pr); // to check their IS_PAID
            } else {
                propertiesToNotify.add(pr); //to send notification
            }
        }
        
        //check IS_PAID if propertiesToCheck not null
        if(propertiesToCheck.size()>0) {
            for(Property__c pro : propertiesToCheck){
                pro.Is_Paid__c=true;
            }
            update propertiesToCheck;
        }
        System.debug(propertiesToNotify);
        //send email if propertiesToNotify not null
        if(propertiesToNotify.size()>0) { 
            
            EmailTemplate tpl = (EmailTemplate)[select Id, Subject, Body  FROM EmailTemplate WHERE Name = 'Notification About Bills Payment'];
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{};
                
                for(Property__c pro : propertiesToNotify) {
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.toAddresses = new String[]{pro.Tenant__r.Email};
                        message.plainTextBody = tpl.Body;
                    messages.add(message);
                }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            System.debug(results);
        }
    }  
    
    public void finish(Database.BatchableContext bc) {}
}