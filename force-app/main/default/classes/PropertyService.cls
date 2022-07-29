public with sharing class PropertyService {
    /**
     * method checks for Two Checkboxes - Pets and Smoker - to add additional $100 to rent price for each TRUE.
     * 
     * @param newList new inserted contacts
     * @author kushtar
     */
    public static void petSmokerFeeBeforeInsert(List<Property__c> newPropertyList){
        for (Property__c prop:newPropertyList){
            Integer addionalFee=0;
            if(prop.Pets__c==false && prop.Smoking__c==false){
                continue;
            }
            if(prop.Pets__c && prop.Smoking__c){
                addionalFee+=200;
            }
            else {
                addionalFee+=100;
            }
            if(prop.Monthly_Rent__c!=null){
                prop.Monthly_Rent__c+=addionalFee;
            }
        }
    }
    public static void petFeeBeforeUpdate(Map<Id, Property__c> newPropertyMap, Map<Id, Property__c> oldPropertyMap){
        for (Property__c prop:newPropertyMap.values()){
            Integer addionalFee=0;
            Boolean oldpets=oldPropertyMap.get(prop.id).Pets__c;
            Boolean newpets=prop.Pets__c;
     
            //compare new version to old version. if no change, continue.
            if(newpets==oldpets){
                continue;
            }
            //if old versions were false. now is true. so add $100
            if(oldpets==false ){
                addionalFee=100;
            }     
            //if the old versions were true, then substract 100
            else if (oldpets==true){
                addionalFee=-100;
            }
            if(prop.Monthly_Rent__c!=null){
                prop.Monthly_Rent__c+=addionalFee;
            }
        }
    }
    public static void smokerFeeBeforeUpdate(Map<Id, Property__c> newPropertyMap, Map<Id, Property__c> oldPropertyMap){
        for (Property__c prop:newPropertyMap.values()){
            Integer addionalFee=0;
            Boolean oldsmoking=oldPropertyMap.get(prop.id).Smoking__c;
            Boolean newSmoking = prop.Smoking__c;
            //compare new version to old version. if no change, continue.
            if(newSmoking==oldsmoking){
                continue;
            }
            //if old versions were false. now is true. so add $100
            if(oldsmoking==false){
                addionalFee=100;
            }
           
            //if the old versions were true, then substract 100
            else if (oldsmoking==true){
                addionalFee=-100;
            }
            if(prop.Monthly_Rent__c!=null){
                prop.Monthly_Rent__c+=addionalFee;
            }
        }
    }

}
