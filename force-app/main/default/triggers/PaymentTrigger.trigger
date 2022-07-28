trigger PaymentTrigger on Payments__c (before insert, before update, before delete, after insert, after update, after delete) {
    new PaymentTriggerHandler().run();
}