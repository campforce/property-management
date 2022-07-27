@isTest
    private class LeadServiceTest {
        @isTest 
    private static void updateLeadStatusTest (){
        Lead testLead=new Lead(FirstName='Kamila',LastName='BKK',Company ='MarsCO',Status='Open-Not Contacted');
        
        Test.startTest();
        Insert testLead;
        Test.stopTest();

        testLead= [SELECT ID, Name From Lead WHERE FirstName='Kamila' AND LastName='BKK'];
    System.assertEquals(testLead.Rating, 'Hot'); 
    }
    }
