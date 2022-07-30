@IsTest
private class NotificationBatchTest {
    @IsTest
    public static void sendEmailTest() {
        Property__c testProp = new Property__c(Smoking__c = true, Pets__c = true, Monthly_Rent__c = 1000, Property_Type__c = 'Apartment', End_date__c = System.today().addDays(25));
        insert testProp;

        Test.startTest();
        NotificationBatch batch = new NotificationBatch();
        Database.executeBatch(batch, 200);
        Test.stopTest();
    }
}