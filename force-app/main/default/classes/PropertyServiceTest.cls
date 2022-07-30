@IsTest(SeeAllData=false)
private class PropertyServiceTest {
    @IsTest
    static void propertyServicePositiveInsertTest() {
        //given
        Property__c testProp = new Property__c(Smoking__c = true, Pets__c = true, Monthly_Rent__c = 1000, Property_Type__c = 'Apartment');

        //when
        Test.startTest();
        insert testProp;
        Test.stopTest();

        //then
        Property__c result = [SELECT Monthly_Rent__c FROM Property__c WHERE Id = :testProp.Id];
        System.assertEquals(1200, result.Monthly_Rent__c, 'Result value is ' + result.Monthly_Rent__c);
    }

    @IsTest
    static void propertyServicePositiveUpdateTest() {
        //given
        Property__c testProp = new Property__c(Smoking__c = false, Pets__c = false, Monthly_Rent__c = 1000, Property_Type__c = 'Apartment');
        insert testProp;
        testProp.Smoking__c = true;
        testProp.Pets__c = true;
        
        //when
        Test.startTest();
        update testProp;
        Test.stopTest();

        //then
        Property__c result = [SELECT Monthly_Rent__c FROM Property__c WHERE Id = :testProp.Id];
        System.assertEquals(1200, result.Monthly_Rent__c, 'Result value is ' + result.Monthly_Rent__c);
    }

    @IsTest
    static void monthlyRentCalculatorTest() {
        //given 
        Property__c utIncluded = new Property__c (Monthly_Rent__c = 50, Monthly_Insurance__c = 10, Monthly_Rental_Expense__c = 10,
                Monthly_Utilities__c = 10, Is_Rented__c = true, Utility_Included__c = true, Initial_Investment__c = 10);
        Property__c utNotIncluded = new Property__c (Monthly_Rent__c = 50, Monthly_Insurance__c = 10, Monthly_Rental_Expense__c = 10,
                Monthly_Utilities__c = 10, Is_Rented__c = true, Utility_Included__c = false, Initial_Investment__c = 10);
        Property__c notRented = new Property__c (Monthly_Rent__c = 50, Monthly_Insurance__c = 10, Monthly_Rental_Expense__c = 10,
                Monthly_Utilities__c = 10, Is_Rented__c = false, Utility_Included__c = true);

        //when
        Test.startTest();
        insert utIncluded;
        insert utNotIncluded;
        insert notRented;
        Test.stopTest();


        //then
        Property__c testUtIncluded = [SELECT Id, Monthly_Profit__c, Annual_Expenses__c, Annual_Rent__c, Initial_Investment__c, ROI__c FROM Property__c WHERE Id = :utIncluded.Id];
        Property__c testUtNotIncluded = [SELECT Id, Monthly_Profit__c, Annual_Expenses__c, Annual_Rent__c, Initial_Investment__c, ROI__c FROM Property__c WHERE Id = :utNotIncluded.Id];
        Property__c testNotRented = [SELECT Id, Monthly_Profit__c FROM Property__c WHERE Id = :notRented.Id];

        System.assertEquals(testUtIncluded.Monthly_Profit__c, 20);
        System.assertEquals(testUtIncluded.Annual_Expenses__c, 360);
        System.assertEquals(testUtNotIncluded.Monthly_Profit__c, 30);
        System.assertEquals(testUtNotIncluded.Annual_Expenses__c, 240);
        System.assertEquals(testNotRented.Monthly_Profit__c, null);
        System.assertEquals(testUtIncluded.Annual_Rent__c, 600);
        System.assertEquals(testUtIncluded.ROI__c, 2400);
        System.assertEquals(testUtNotIncluded.ROI__c, 3600);
    }

    @IsTest
    static void checkForBillsEachMonthTest() {
        //given
        Contact newContact = new Contact(Phone = '000', Credit_Score__c = 700, Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(1975, 2, 17), Email = 'test@gmail.com', LastName = 'Zhaniev');
        insert newContact;
        Payments__c newPayment = new Payments__c(Date__c = Date.newInstance(2022, 7, 17), Tenants__c = newContact.Id);
        insert newPayment;
        Property__c newProperty = new Property__c(Is_Rented__c = true, Is_Paid__c = false, Tenant__c = newContact.Id);

        //when
        Test.startTest();
        insert newProperty;
        Test.stopTest();
    }
}