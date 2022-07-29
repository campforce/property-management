@isTest
    private class LeadServiceTest {
        @isTest 
    private static void updateLeadStatusTest (){
        Lead testLead=new Lead(FirstName='Kamila',LastName='BKK',Company ='MarsCO',Status='Open-Not Contacted',LeadSource = 'Partner Referral');
        
        Test.startTest();
        Insert testLead;
        Test.stopTest();

        testLead= [SELECT ID, Rating From Lead WHERE FirstName='Kamila' AND LastName='BKK'];
    System.assertEquals(testLead.Rating, 'Hot'); 
    }
    
    /**
     * Test to trigger which create new related task when Lead inserted
     */

    @isTest 
    public static void afterinsertTaskLeadTest() {
    //given
    Lead testLead=new Lead(FirstName='Erika',LastName='Kim',Company ='Apple',Status='Open-Not Contacted', Rating = 'Hot');
    //when
    Test.startTest();
    Insert testLead;
    //then
    Test.stopTest();
    List <Task> lstTask = [SELECT ID, Subject From Task];
    System.assertEquals(lstTask.size(), 1);
    System.assertEquals(lstTask[0].Subject, 'Contact in 24 hours');
}
 @isTest
    public static void afterinsertTaskLeadTest2() {
    //given
    Lead testLead=new Lead(FirstName='Erika',LastName='Kim',Company ='Apple',Status='Open-Not Contacted', Rating = 'Hot');
    //when
    Test.startTest();
    Insert testLead;
    //then
    Test.stopTest();
    List <Task> lstTask = [SELECT ID, Subject From Task];
    System.assertEquals(lstTask[0].Subject, 'Contact in 24 hours');
}

}
