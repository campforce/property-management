 /**
     * Batch method to check for finished rent in properties and deleting contacts
     * 
     * 
     * @author MartinCapek
     */


    public class PropertyLeaveBatch implements Database.Batchable<sObject>,schedulable{ 
        public static void execute (schedulablecontext ctx){} 
        
        //Select Property ID and Tenant Id from property, where end date is today or less and is still rented
        public Database.QueryLocator start(Database.BatchableContext BC) {
            return Database.getQueryLocator ('SELECT Id,End_date__c,tenant__c FROM property__c WHERE End_date__c <= today AND IS_rented__C = true');
        } 

        
        public void execute(Database.BatchableContext BC, List<property__C> propList) {
            Set <id> contIds = new set <id>();
            // process each batch of records default size 200
            for(property__c prop : propList) {        
                // Update the Account Name 
                prop.IS_rented__C = false;
                contIds.add(prop.tenant__c);
                
            }   
            update proplist;    
            
            list <contact> clist =[SELECT Id FROM contact WHERE id IN :contIds ];
            Delete clist;  
        } 
       public void finish(Database.BatchableContext BC) {
        
        }
    }
      
             
          
         
        