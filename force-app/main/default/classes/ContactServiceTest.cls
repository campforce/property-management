@IsTest(SeeAllData=false)
private class ContactServiceTest {
    
    @IsTest
    static void validateTenantWithBadInputsTest() {
        //given
        Contact tooYoung = new Contact(Credit_Score__c = 630, Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(2010, 2, 17));
        Contact unemployeedTenant = new Contact(Credit_Score__c = 630, Occupation__c = 'Student', Birthdate = Date.newInstance(1975, 2, 17));
        Contact lowCreditScore = new Contact(Credit_Score__c = 628,  Occupation__c = 'Software Engineer', Birthdate = Date.newInstance(1975, 2, 17));

        //when
        Test.startTest();
        Database.SaveResult resultTooYounng = Database.insert(tooYoung, false);
        Database.SaveResult resultUnemployeedTenant = Database.insert(unemployeedTenant, false);
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
        Contact testTenant = new Contact(LastName = 'test', Credit_Score__c = 630, Occupation__c = 'Software Engineer',  Birthdate = Date.newInstance(1975, 2, 17));

        //when
        Test.startTest();
        Database.SaveResult result = Database.insert(testTenant, false);       
        Test.stopTest();
        
        //then
        System.assert(result.isSuccess());
    }  
}
