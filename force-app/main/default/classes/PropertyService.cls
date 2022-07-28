public with sharing class PropertyService {
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

    