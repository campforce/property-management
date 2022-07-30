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


private class PropertyServiceTest{
    
    @IsTest
    static void MonthlyRentCalculatorTest() {
        //given 
        property__c utIncluded= new property__c (Monthly_rent__c = 50, Monthly_insurance__c = 10, monthly_rental_Expense__c = 10,
                                                Monthly_utilities__c = 10, Is_Rented__c=true, Utility_included__c = true , initial_investment__C = 10);
        property__c utNotIncluded= new property__c (Monthly_rent__c = 50, Monthly_insurance__c = 10, monthly_rental_Expense__c = 10,
                                                Monthly_utilities__c = 10, Is_Rented__c = true, Utility_included__c = false, initial_investment__C = 10);
        property__c notRented= new property__c (Monthly_rent__c = 50, Monthly_insurance__c = 10, monthly_rental_Expense__c = 10,
                                                Monthly_utilities__c=10, Is_Rented__c = false, Utility_included__c=true);


        //when
        Test.startTest();
        insert UtIncluded;
        insert utNotIncluded;
        insert notRented; 
        Test.stopTest();


        //then
        property__c testUtIncluded= [SELECT id, Monthly_profit__c,annual_Expenses__c,annual_rent__c,initial_investment__C,roi__c FROM property__c WHERE ID=:utIncluded.id ];
        property__c testutNotIncluded= [SELECT id, Monthly_profit__c,annual_Expenses__c,annual_rent__c,initial_investment__C,roi__c FROM property__c WHERE ID=:utNotIncluded.id ];
        property__c testnotRented= [SELECT id, Monthly_profit__c FROM property__c WHERE ID=: notRented.id ];
        
        
        System.assertEquals(testUtIncluded.Monthly_profit__c,20);
        System.assertEquals(testutIncluded.annual_Expenses__c,360);
        System.assertEquals(testutNotIncluded.Monthly_profit__c,30);
        System.assertEquals(testutNotIncluded.annual_Expenses__c,240);
        System.assertEquals(testnotRented.Monthly_profit__c,null);
        System.assertEquals(testutIncluded.annual_rent__c,600);
        System.assertEquals(testutIncluded.roi__c,2400);
        System.assertEquals(testutNotIncluded.roi__c,3600);


    }

    @IsTest
    static void checkForBillsEachMonthTest(){
        //given
        Contact newContact = new Contact(Phone = '000', Credit_Score__c = 700,  Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(1975, 2, 17), Email='test@gmail.com', LastName='Zhaniev');
        insert newContact;
        Payments__c newPayment = new Payments__c(Date__c= Date.newInstance(2022, 7, 17), Tenants__c=newContact.Id);
        insert newPayment;
        Property__c newProperty = new Property__c(Is_Rented__c=true, Is_Paid__c=false, Tenant__c=newContact.Id);

        
        //when
        Test.startTest();
        insert newProperty;
        Test.stopTest();

  
    }
}

