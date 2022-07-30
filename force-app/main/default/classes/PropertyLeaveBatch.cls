/**
 * Batch class to check for finished rent in properties and deleting Contacts
 * @author MartinCapek
 */
public class PropertyLeaveBatch implements Database.Batchable<SObject>, Schedulable {
    public static void execute(SchedulableContext ctx) {
        PropertyLeaveBatch batch = new PropertyLeaveBatch();
        Database.executeBatch(batch, 200);
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator ('SELECT Id,End_date__c,tenant__c FROM property__c WHERE End_date__c <= today AND IS_rented__C = true');
    }

    public void execute(Database.BatchableContext BC, List<Property__c> propList) {
        Set <Id> contIds = new Set <Id>();

        // process each batch of records default size 200
        for (Property__c prop : propList) {
            // Update the Account Name 
            prop.Is_Rented__c = false;
            contIds.add(prop.Tenant__c);
        }

        update propList;

        List <Contact> cList = [SELECT Id FROM Contact WHERE Id IN :contIds];
        delete cList;
    }

    public void finish(Database.BatchableContext BC) {
    }
}
      
             
          
         
        