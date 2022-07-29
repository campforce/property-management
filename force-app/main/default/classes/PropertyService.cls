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

 /**
     * Method to calculate Monthly profit, annual rent, annual expenses and ROI for one property based on current situation
     * 
     * @param newList new inserted,updated properties
     * @author MartinCapek
     */



    public static void IncomeCalculator(List<Property__c>newlist){
        For (Property__c prop:newlist){
        // Monthly rent

            //Utilities included (paid by us)
            If (prop.Is_Rented__c !=false && prop.Monthly_rent__c !=null && prop.Monthly_insurance__c !=null && prop.Monthly_rent__c !=null 
                && prop.Utility_included__c==true && prop.Monthly_rental_Expense__c!=null ){
                 prop.Monthly_profit__c=prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c-prop.Monthly_Utilities__C;
            }
            
            //Utilities not included (paid by tennant)
            ELSE IF (prop.Is_Rented__c !=false && prop.Monthly_rent__c !=null && prop.Monthly_insurance__c !=null && prop.Monthly_rent__c !=null 
                     && prop.Utility_included__c==false && prop.Monthly_rental_Expense__c!=null){
                        prop.Monthly_profit__c=  prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c;
            }

            //not rented
            ELSE IF (prop.Is_rented__c==false){
                    prop.Monthly_profit__c = null; 
            }
       
        //annual rent calculation
            If (prop.Monthly_rent__c !=null){
                prop.annual_rent__c = prop.Monthly_rent__c *12;
            }
            ELSE {
                    prop.annual_rent__c =null;
            }
        //annual expenses
            //utility included
            If (prop.Utility_included__c==true && prop.Monthly_rental_Expense__c !=null && prop.Monthly_insurance__c !=null && prop.Monthly_Utilities__C!=null){
                    prop.annual_expenses__c = (prop.Monthly_rental_Expense__c + prop.Monthly_insurance__c+prop.Monthly_Utilities__C)*12;
            }
            //utility not included
            Else If (prop.Utility_included__c==false && prop.Monthly_rental_Expense__c !=null && prop.Monthly_insurance__c!=null){
                    prop.annual_expenses__c = (prop.Monthly_rental_Expense__c + prop.Monthly_insurance__c)*12;
            }
         
        //Estimated ROI after one year paid rent               
            If (prop.Utility_included__c==true && prop.initial_investment__C !=null){
                prop.ROI__c = (prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c - prop.Monthly_Utilities__C)*12 / prop.initial_investment__c*100;
            }
            ELSE IF (prop.initial_investment__C !=null) {
                prop.ROI__c = (prop.Monthly_rent__c - prop.monthly_rental_Expense__c - prop.Monthly_insurance__c)*12 / prop.initial_investment__c*100;    
            }
            ELSE {
                prop.ROI__c =null;
            }
        }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    }
}

    