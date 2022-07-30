@IsTest(SeeAllData=false)
private class ContactServiceTest {

    @IsTest
    static void validateTenantWithBadInputsTest() {
        //given
        Contact tooYoung = new Contact(RecordTypeId = ContactService.TENANT_RECORD_TYPE_ID, LastName = 'test', Phone = '000', Credit_Score__c = 630, Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(2010, 2, 17), Email = 'tooyoung@gmail.com');
        Contact unemployedTenant = new Contact(RecordTypeId = ContactService.TENANT_RECORD_TYPE_ID, LastName = 'test', Phone = '000', Credit_Score__c = 630, Occupation__c = 'Student', Birthdate = Date.newInstance(1975, 2, 17), Email = 'tooyoung@gmail.com');
        Contact lowCreditScore = new Contact(RecordTypeId = ContactService.TENANT_RECORD_TYPE_ID, LastName = 'test', Phone = '000', Credit_Score__c = 628, Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(1975, 2, 17), Email = 'tooyoung@gmail.com');


        //when
        Test.startTest();
        Database.SaveResult resultTooYounng = Database.insert(tooYoung, false);
        Database.SaveResult resultUnemployeedTenant = Database.insert(unemployedTenant, false);
        Database.SaveResult resultLowCreditScore = Database.insert(lowCreditScore, false);
        Test.stopTest();

        //then
        System.assertEquals(resultTooYounng.getErrors()[0].getMessage(), 'This tenant is too young to deal with.');
        System.assertEquals(resultUnemployeedTenant.getErrors()[0].getMessage(), 'This tenant is Student or unemployed.');
        System.assertEquals(resultLowCreditScore.getErrors()[0].getMessage(), 'This tenant has too low credit score. It should be more than 629.');
    }

    @IsTest
    static void validateTenantWithGoodInputsTest() {
        //given
        Contact testTenant = new Contact(Phone = '000', LastName = 'test', Credit_Score__c = 630, Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(1975, 2, 17), Email = 'tooyoung@gmail.com');

        //when
        Test.startTest();
        Database.SaveResult result = Database.insert(testTenant, false);
        Test.stopTest();

        //then
        System.assert(result.isSuccess());
    }

    @IsTest
    static void validatePhoneTest() {
        //given
        Contact testContact = new Contact(Phone = 'test string');
        //when
        Test.startTest();
        Database.SaveResult result = Database.insert(testContact, false);
        Test.stopTest();
        //then
        System.assertEquals(result.getErrors()[0].getMessage(), 'Phone can be only numbers');
    }

    @IsTest
    static void sendWelcomeEmailPositiveTest() {
        //given
        Contact newContact = new Contact(Phone = '000', Credit_Score__c = 700, Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(1975, 2, 17), Email = 'test@gmail.com', LastName = 'Zhaniev');

        //when
        Test.startTest();
        insert newContact;
        Test.stopTest();
    }
}
