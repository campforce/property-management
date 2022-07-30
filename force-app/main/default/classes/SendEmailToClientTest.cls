@IsTest
public with sharing class SendEmailToClientTest {
    @IsTest
    public static void SendEmailTest(){
        Property__c testProp = new Property__c(Smoking__c=true, Pets__c=true,Monthly_rent__c=1000,Property_type__c='Apartment', End_date__c = system.today().addDays(25));
        SendEmailToClient batch = new SendEmailToClient();
Database.executeBatch(batch, 200);
    }
}