public class PaymentService {
    public static void isPaid(List<Payments__c> newPaymentList) {
        Set<Id> ppIds = new Set<Id>();

        for (Payments__c p : newPaymentList) {
            if (p.Amount__c != null) {
                ppIds.add(p.Property__c);
            }
        }

        List<Property__c> propertiesToUpdate = new List<Property__c>();

        for (Property__c pp : [SELECT Id, Is_Paid__c FROM Property__c WHERE Id IN :ppIds]) {
            pp.Is_Paid__c = true;
            propertiesToUpdate.add(pp);
        }

        update propertiesToUpdate;
    }
}
