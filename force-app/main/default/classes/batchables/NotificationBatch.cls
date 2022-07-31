/**
 * Notify tenant for extending renting period before 30 days of end date
 * @author Talant
 */
public class NotificationBatch implements Database.Batchable<SObject>, Schedulable {
    
    public void execute(System.SchedulableContext sc) {
        NotificationBatch batch = new NotificationBatch();
        Database.executeBatch(batch, 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT id, End_date__c, Tenant__r.Email, Tenant__r.Lastname FROM Property__c WHERE End_date__c = NEXT_N_DAYS:30');
    }

    public void execute(Database.BatchableContext bc, List<Property__c> properties) {
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{};

        for (Property__c pro : properties) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = new String[]{pro.Tenant__r.Email};
            message.plainTextBody = 'Hello, ' + pro.Tenant__r.LastName + ' Our Contract Expiring day is coming, if u want to extend call me 79965603267';
            messages.add(message);
        }
        
        Messaging.sendEmail(messages);
    }

    public void finish(Database.BatchableContext bc) {}
}