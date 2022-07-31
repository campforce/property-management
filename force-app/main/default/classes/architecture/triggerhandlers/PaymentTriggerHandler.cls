public class PaymentTriggerHandler extends TriggerHandler {

    private List<Payments__c> newPaymentList;
    private List<Payments__c> oldPaymentList;
    private Map<Id, Payments__c> newPaymentMap;
    private Map<Id, Payments__c> oldPaymentMap;

    public PaymentTriggerHandler() {
        this.newPaymentList = (List<Payments__c>) Trigger.new;
        this.oldPaymentList = (List<Payments__c>) Trigger.old;
        this.newPaymentMap = (Map<Id, Payments__c>) Trigger.newMap;
        this.oldPaymentMap = (Map<Id, Payments__c>) Trigger.oldMap;
    }

    public override void afterInsert() {
        PaymentService.isPaid(newPaymentList);
    }
    public override void afterUpdate() {
        PaymentService.isPaid(newPaymentList);
    }
}
