@IsTest(SeeAllData=false)
public with sharing class PaymentServiceTest {
    
    @IsTest
    static void paymentServicePositiveTest() {
        //given 
        Property__c proper = new Property__c (Property_type__c = 'Apartment');
        insert proper;
        
        Payments__c relatedPay = new Payments__c(Amount__c = 2000, Property__c = proper.Id);

        // when
        test.startTest();
        insert relatedPay;
        test.stopTest();
        
        //then
        Property__c result = [SELECT Is_Paid__c FROM Property__c];
        system.assertEquals(true, result.Is_Paid__c);
    }
}
