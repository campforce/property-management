@IsTest(SeeAllData=false)
private class DummyTest {

    @IsTest
    static void testTriggers() {
        insert new Lead(LastName = 'test', Company = 'test');
        insert new Property__c();
        insert new Account(Name = 'test');
        insert new Opportunity(Name = 'test', StageName = 'New', CloseDate = Date.newInstance(2022, 09, 01));
        insert new Case(Subject = 'test');
        insert new Payments__c();
    }
}
