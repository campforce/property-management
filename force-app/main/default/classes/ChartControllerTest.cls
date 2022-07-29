@IsTest(SeeAllData=false)
public with sharing class ChartControllerTest {
    @isTest
    static void ChartControllerPositiveTest() {

        //given
        List <Property__c> propertytest = new List<Property__c> ();
        //Map<String, Integer> propertytest = new Map<String, Integer>();
        propertytest.add(new Property__c(Property_Type__c='Apartment'));
        propertytest.add(new Property__c(Property_Type__c='House'));
        propertytest.add(new Property__c(Property_Type__c='Penthouse'));
        propertytest.add(new Property__c(Property_Type__c='Townhomes'));
        propertytest.add(new Property__c(Property_Type__c='Yurt'));

        //when
        Test.startTest();
        insert propertytest;
        Test.stopTest();

        //Then
        Integer expectedsize = propertytest.size();
        Integer actualsize = ChartController.getStatistics().size();

        System.assertEquals(expectedsize, actualsize);

    }
}
