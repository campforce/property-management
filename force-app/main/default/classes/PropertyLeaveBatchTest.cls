@IsTest(SeeAllData=false)
private class PropertyLeaveBatchTest {

    @IsTest
    static void endToday() {
        //given
        Contact con1 = new Contact (Credit_Score__c = 1000, Income__c = 1000, Email = 'test@test.gmail.com', LastName = 'test', Birthdate = Date.newInstance(2000, 1, 1), Occupation__c = 'manager');
        Contact con2 = new Contact (Credit_Score__c = 1000, Income__c = 1000, Email = 'test2@test2.gmail.com', LastName = 'test2', Birthdate = Date.newInstance(2001, 1, 1), Occupation__c = 'manager');

        Property__c prop1 = new Property__c (Is_Rented__c = true, End_date__c = System.today(), Tenant__c = con1.Id);
        Property__c prop2 = new Property__c (Is_Rented__c = true, End_date__c = System.today().addDays(+1), Tenant__c = con2.Id);

        insert new List<Contact> {con1, con2};
        insert new List<Property__c> {prop1, prop2};

        prop1.Tenant__c = con1.Id;
        prop2.Tenant__c = con2.Id;

        update new List<Property__c> {prop1, prop2};

        //when
        Test.startTest();
        PropertyLeaveBatch bc = new PropertyLeaveBatch();
        Database.executeBatch(bc);
        Test.stopTest();

        //then
        Property__c testProp1 = [SELECT Id, Is_Rented__c FROM Property__c WHERE Id = :prop1.Id LIMIT 1];
        Property__c testProp2 = [SELECT Id, Is_Rented__c, Tenant__c FROM Property__c WHERE Id = :prop2.Id LIMIT 1];
        Integer count = [SELECT COUNT() FROM Contact WHERE Id = :con1.Id];
        Integer count2 = [SELECT COUNT() FROM Contact WHERE Id = :con2.Id];

        System.assertEquals(count, 0);
        System.assertEquals(count2, 1);

        System.assertEquals(testProp1.Is_Rented__c, false);
        System.assertEquals(testProp2.Is_Rented__c, true);
    }
}