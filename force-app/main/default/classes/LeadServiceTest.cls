@IsTest
private class LeadServiceTest {

    @IsTest
    private static void updateLeadStatusTest() {
        Lead testLead = new Lead(FirstName = 'Kamila', LastName = 'BKK', Company = 'MarsCO', Status = 'Open-Not Contacted', LeadSource = 'Partner Referral');

        Test.startTest();
        insert testLead;
        Test.stopTest();

        testLead = [SELECT Id, Rating FROM Lead WHERE FirstName = 'Kamila' AND LastName = 'BKK'];
        System.assertEquals(testLead.Rating, 'Hot');
    }

    /**
     * Test to trigger which create new related task when Lead inserted
     */
    @IsTest
    public static void afterInsertTaskLeadTest() {
        //given
        Lead testLead = new Lead(FirstName = 'Erika', LastName = 'Kim', Company = 'Apple', Status = 'Open-Not Contacted', Rating = 'Hot');

        //when
        Test.startTest();
        insert testLead;
        Test.stopTest();

        //then
        List <Task> lstTask = [SELECT Id, Subject FROM Task];
        System.assertEquals(lstTask.size(), 1);
        System.assertEquals(lstTask[0].Subject, 'Contact in 24 hours');
    }
    @IsTest
    public static void afterInsertTaskLeadTest2() {
        //given
        Lead testLead = new Lead(FirstName = 'Erika', LastName = 'Kim', Company = 'Apple', Status = 'Open-Not Contacted', Rating = 'Hot');

        //when
        Test.startTest();
        insert testLead;
        Test.stopTest();

        //then
        List <Task> lstTask = [SELECT Id, Subject FROM Task];
        System.assertEquals(lstTask[0].Subject, 'Contact in 24 hours');
    }
}
