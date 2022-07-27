@isTest
    private class LeadServiceTest {
        @isTest 
    private static void updateLeadStatusTest (){
        Lead testLead=new Lead(FirstName='Kamila',LastName='BKK',
                               Company ='MarsCO',Status='Open-Not Contacted');
        
        System.Test.startTest();
        Insert testLead;
        System.Test.stopTest();

        testLead= [SELECT ID, Rating From Lead WHERE FirstName='Kamila' AND LastName='BKK'];
    System.assertEquals(testLead.Rating, 'Hot'); 
    }
    }
