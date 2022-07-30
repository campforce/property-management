@IsTest(SeeAllData=false)
private class ChartControllerTest {
    @IsTest
    static void chartControllerPositiveTest() {
        //given
        List <Property__c> propertyTest = new List<Property__c> ();
        propertyTest.add(new Property__c(Property_Type__c = 'Apartment'));
        propertyTest.add(new Property__c(Property_Type__c = 'House'));
        propertyTest.add(new Property__c(Property_Type__c = 'Penthouse'));
        propertyTest.add(new Property__c(Property_Type__c = 'Townhomes'));
        propertyTest.add(new Property__c(Property_Type__c = 'Yurt'));

        //when
        Test.startTest();
        insert propertyTest;
        Test.stopTest();

        //Then
        Integer expectedSize = propertyTest.size();
        Integer actualSize = ChartController.getStatistics().size();
        System.assertEquals(expectedSize, actualSize);
    }
}
