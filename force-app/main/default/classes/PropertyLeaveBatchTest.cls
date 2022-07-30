@IsTest(SeeAllData=false)

private class PropertyLeaveBatchTest{
    
    @IsTest
    static void EndToday() {
        //given
        
        contact con1  =new contact (Credit_Score__c=1000,income__c=1000,email='test@test.gmail.com',lastname='test',birthdate=Date.newInstance(2000, 1, 1), Occupation__c='manager');
        contact con2  =new contact (Credit_Score__c=1000,income__c=1000,email='test2@test2.gmail.com',lastname='test2',birthdate=Date.newInstance(2001, 1, 1), Occupation__c='manager');

        property__c prop1= new property__c (Is_Rented__c=true, End_date__c = system.today(), tenant__c = con1.Id);
        property__c prop2= new property__c (Is_Rented__c=true, End_date__c = system.today().addDays(+1), tenant__c = con2.id);
        
        insert con1;
        insert prop1;
        insert con2;
        insert prop2;
        prop1.tenant__C=con1.Id;
        prop2.tenant__C=con2.Id;
        update prop1;
        update prop2;
         

        //when
        Test.startTest();
        
        PropertyLeaveBatch bc = new PropertyLeaveBatch();
        database.executeBatch(bc);
        Test.stopTest();


        //then
        
      	property__c testprop1= [SELECT id,is_rented__C FROM property__c WHERE id=:prop1.id limit  1 ];
        property__c testprop2= [SELECT id,is_rented__C,tenant__c FROM property__c WHERE id=:prop2.id limit  1 ];
        integer count = [SELECT COUNT() FROM Contact WHERE Id = :con1.id];
        integer count2 =[SELECT COUNT() FROM Contact WHERE Id = :con2.id];
        

        System.assertEquals(count,0);
        System.assertEquals(count2,1);

        
        System.assertEquals(testprop1.is_rented__c,false);
        System.assertEquals(testprop2.is_rented__c,true);
  
    }
}