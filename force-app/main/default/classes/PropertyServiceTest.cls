@IsTest(SeeAllData=false)
public with sharing class PropertyServiceTest {
    @isTest
    static void PropertyServicePositiveInsertTest() {


        //given
        Property__c testProp = new Property__c(Smoking__c=true, Pets__c=true,Monthly_rent__c=1000,Property_type__c='Apartment');
       

        //when
        test.startTest();
        insert testProp;
        test.stopTest();

        //then
        Property__c result = [select Monthly_rent__c from Property__c where id =:testProp.id];
        System.assertEquals(1200, result.Monthly_Rent__c,'Result value is '+ result.Monthly_Rent__c);
    }

    @isTest
    static void PropertyServicePositiveUpdateTest() {


        //given
        Property__c testProp = new Property__c(Smoking__c=false, Pets__c=false,Monthly_rent__c=1000,Property_type__c='Apartment');
        insert testProp;
        testProp.Smoking__c=true;
        testProp.Pets__c=true;
        //when
        test.startTest();
        update testProp;
        test.stopTest();

        //then
        Property__c result = [select Monthly_rent__c from Property__c where id =:testProp.id];
        System.assertEquals(1200, result.Monthly_Rent__c,'Result value is '+ result.Monthly_Rent__c);
    }
}