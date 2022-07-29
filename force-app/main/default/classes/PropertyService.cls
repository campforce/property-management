public with sharing class PropertyService implements Database.Batchable<SObject>, Schedulable {
 /**
     * Method to calculate Monthly profit, annual rent, annual expenses and ROI for one property based on current situation
     * 
     * @param newList new inserted,updated properties
     * @author MartinCapek
     */


    public static void IncomeCalculator(List<Property__c>newlist){
        For (Property__c prop:newlist){
        // Monthly rent

            //Utilities included (paid by us)
            If (prop.Is_Rented__c !=false && prop.Monthly_rent__c !=null && prop.Monthly_insurance__c !=null && prop.Monthly_rent__c !=null 
                && prop.Utility_included__c==true && prop.Monthly_rental_Expense__c!=null ){
                 prop.Monthly_profit__c=prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c-prop.Monthly_Utilities__C;
            }
            
            //Utilities not included (paid by tennant)
            ELSE IF (prop.Is_Rented__c !=false && prop.Monthly_rent__c !=null && prop.Monthly_insurance__c !=null && prop.Monthly_rent__c !=null 
                     && prop.Utility_included__c==false && prop.Monthly_rental_Expense__c!=null){
                        prop.Monthly_profit__c=  prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c;
            }

            //not rented
            ELSE IF (prop.Is_rented__c==false){
                    prop.Monthly_profit__c = null; 
            }
       
        //annual rent calculation
            If (prop.Monthly_rent__c !=null){
                prop.annual_rent__c = prop.Monthly_rent__c *12;
            }
            ELSE {
                    prop.annual_rent__c =null;
            }
        //annual expenses
            //utility included
            If (prop.Utility_included__c==true && prop.Monthly_rental_Expense__c !=null && prop.Monthly_insurance__c !=null && prop.Monthly_Utilities__C!=null){
                    prop.annual_expenses__c = (prop.Monthly_rental_Expense__c + prop.Monthly_insurance__c+prop.Monthly_Utilities__C)*12;
            }
            //utility not included
            Else If (prop.Utility_included__c==false && prop.Monthly_rental_Expense__c !=null && prop.Monthly_insurance__c!=null){
                    prop.annual_expenses__c = (prop.Monthly_rental_Expense__c + prop.Monthly_insurance__c)*12;
            }
         
        //Estimated ROI after one year paid rent               
            If (prop.Utility_included__c==true && prop.initial_investment__C !=null){
                prop.ROI__c = (prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c - prop.Monthly_Utilities__C)*12 / prop.initial_investment__c*100;
            }
            ELSE IF (prop.initial_investment__C !=null) {
                prop.ROI__c = (prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c)*12 / prop.initial_investment__c*100;    
            }
            ELSE {
                prop.ROI__c =null;
            }
        }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    }


    /**
     *  Payments__c custom object with relationship to Tenant and Property object.
There is fields:
- Date__c
- Amount__c

Create batch which will go through for all records in Property object.
It will check if Property isRent and isPaid:
- if yes → it will check if property has related payments record in current month
- If no → it will send email reminder to tenant
     * 
     * @author GulnazAtabaeva
     */

    public void execute(System.SchedulableContext sc) {
        CheckForBillsEachMonth batch = new CheckForBillsEachMonth();
        Database.executeBatch(batch, 200);
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator('SELECT Id, Is_Rented__c, Is_Paid__c FROM Property__c Where Is_Rented__c=true ANd Is_Paid__c=false');
    }
    
    public void execute(Database.BatchableContext bc, List<Property__c> properties) {
        Map<Id, Property__c> propertyMap = new Map<Id, Property__c>(properties);
        List<Payments__c> paymentList = [Select Tenants__r.Email, Tenants__r.LastName From Payments__c Where Property__c IN: propertyMap.keySet() AND Date__c!=LAST_N_DAYS:30];
        System.debug(paymentList.size());
        if(paymentList.size()>0){
            
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{};
		
        for(Payments__c pro : paymentList) {
            
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.toAddresses = new String[]{pro.Tenants__r.Email};
                message.plainTextBody = 'Hello, ' + pro.Tenants__r.LastName + ' you didn\'t pay your bill on time. Please pay your bills on time.';
                messages.add(message);
            System.debug('');
            }                
            	Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

        }        
    } 
    public void finish(Database.BatchableContext bc) {}
}

    