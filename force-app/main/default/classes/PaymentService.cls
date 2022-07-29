public class PaymentService {
    public static void isPaid(List<Payments__c> newPaymentList){
        set<id> ppIds = new set<id>();
            for(Payments__c p: newPaymentList){
            if(p.Amount__c!=null){
            ppIds.add(p.Proper12__c);
            }
            }
            list<Property__c>  pplist = [select id, is_paid__c
            from Property__c where id in: ppIds ];
            for(Property__c pp: pplist){
            pp.is_paid__c=true;
            }
            update pplist;
            }
        }
    
