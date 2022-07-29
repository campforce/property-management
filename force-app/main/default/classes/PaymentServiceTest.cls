@IsTest(SeeAllData=false)
public with sharing class PaymentServiceTest {
    @IsTest
    static void PaymentServicePositiveTest() {
        //given 
        Property__c proper = new Property__c (property_type__c = 'Apartment');
        insert proper; 
        Payments__c relatedPay = new Payments__c(Amount__c = 2000, Proper12__c = proper.Id);
        // when
        test.startTest();
        insert relatedPay;
        test.stopTest();
        //then
        Property__c checkIsPay = [select is_paid__c from Property__c];
        system.assertEquals(true, checkIsPay.is_paid__c);
    }
}
