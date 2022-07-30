public with sharing class PropertyService {

    /**
     *Method checks for Two Checkboxes - Pets and Smoker - to add additional $100 to rent price for each TRUE.
     * 
     * @param newPropertyList new inserted properties
     * @author kushtar
     */
    public static void petSmokerFeeBeforeInsert(List<Property__c> newPropertyList) {
        for (Property__c prop : newPropertyList) {
            Integer additionalFee = 0;
            if (prop.Pets__c == false && prop.Smoking__c == false) {
                continue;
            }
            if (prop.Pets__c && prop.Smoking__c) {
                additionalFee += 200;
            } else {
                additionalFee += 100;
            }
            if (prop.Monthly_Rent__c != null) {
                prop.Monthly_Rent__c += additionalFee;
            }
        }
    }

    /**
     * Method checks on update for Two Checkboxes - Pets and Smoker - to add additional $100 to rent price for each TRUE.
     *
     * @param newPropertyMap new properties
     * @param oldPropertyMap old properties
     * @author kushtar
     */
    public static void petFeeBeforeUpdate(Map<Id, Property__c> newPropertyMap, Map<Id, Property__c> oldPropertyMap) {
        for (Property__c prop : newPropertyMap.values()) {
            Integer additionalFee = 0;
            Boolean oldPets = oldPropertyMap.get(prop.Id).Pets__c;
            Boolean newPets = prop.Pets__c;

            //compare new version to old version. if no change, continue.
            if (newPets == oldPets) {
                continue;
            }
            //if old versions were false. now is true. so add $100
            if (oldPets == false) {
                additionalFee = 100;
            }
            //if the old versions were true, then substract 100
            else if (oldPets == true) {
                additionalFee = -100;
            }
            if (prop.Monthly_Rent__c != null) {
                prop.Monthly_Rent__c += additionalFee;
            }
        }
    }

    /**
     * Method checks on update for Two Checkboxes - Pets and Smoker - to add additional $100 to rent price for each TRUE.
     *
     * @param newPropertyMap new properties
     * @param oldPropertyMap old properties
     * @author kushtar
     */
    public static void smokerFeeBeforeUpdate(Map<Id, Property__c> newPropertyMap, Map<Id, Property__c> oldPropertyMap) {
        for (Property__c prop : newPropertyMap.values()) {
            Integer additionalFee = 0;
            Boolean oldSmoking = oldPropertyMap.get(prop.Id).Smoking__c;
            Boolean newSmoking = prop.Smoking__c;
            //compare new version to old version. if no change, continue.
            if (newSmoking == oldSmoking) {
                continue;
            }
            //if old versions were false. now is true. so add $100
            if (oldSmoking == false) {
                additionalFee = 100;
            }

            //if the old versions were true, then substract 100
            else if (oldSmoking == true) {
                additionalFee = -100;
            }
            if (prop.Monthly_Rent__c != null) {
                prop.Monthly_Rent__c += additionalFee;
            }
        }
    }

    /**
     * Method to calculate Monthly profit, annual rent, annual expenses and ROI for one property based on current situation
     *
     * @param newList new inserted,updated properties
     * @author MartinCapek
     */
    public static void incomeCalculator(List<Property__c> newList) {
        for (Property__c prop : newList) {
            // Monthly rent
            //Utilities included (paid by us)
            if (prop.Is_Rented__c != false && prop.Monthly_Rent__c != null && prop.Monthly_Insurance__c != null && prop.Monthly_Rent__c != null
                    && prop.Utility_Included__c == true && prop.Monthly_Rental_Expense__c != null) {
                prop.Monthly_Profit__c = prop.Monthly_Rent__c - prop.Monthly_Rental_Expense__c - prop.Monthly_Insurance__c - prop.Monthly_Utilities__c;
            }

            //Utilities not included (paid by tenant)
            else if (prop.Is_Rented__c != false && prop.Monthly_Rent__c != null && prop.Monthly_Insurance__c != null && prop.Monthly_Rent__c != null
                    && prop.Utility_Included__c == false && prop.Monthly_Rental_Expense__c != null) {
                prop.Monthly_Profit__c = prop.Monthly_Rent__c - prop.Monthly_Rental_Expense__c - prop.Monthly_Insurance__c;
            } else if (prop.Is_Rented__c == false) { //not rented
                prop.Monthly_Profit__c = null;
            }

            //annual rent calculation
            if (prop.Monthly_Rent__c != null) {
                prop.Annual_Rent__c = prop.Monthly_Rent__c * 12;
            } else {
                prop.Annual_Rent__c = null;
            }

            //annual expenses

            //utility included
            if (prop.Utility_Included__c == true && prop.Monthly_Rental_Expense__c != null && prop.Monthly_Insurance__c != null && prop.Monthly_Utilities__c != null) {
                prop.Annual_Expenses__c = (prop.Monthly_Rental_Expense__c + prop.Monthly_Insurance__c + prop.Monthly_Utilities__c) * 12;
            } else if (prop.Utility_Included__c == false && prop.Monthly_Rental_Expense__c != null && prop.Monthly_Insurance__c != null) {
                prop.Annual_Expenses__c = (prop.Monthly_Rental_Expense__c + prop.Monthly_Insurance__c) * 12;
            }

            //Estimated ROI after one year paid rent               
            if (prop.Utility_Included__c == true && prop.Initial_Investment__c != null) {
                prop.ROI__c = (prop.Monthly_Rent__c - prop.Monthly_Rental_Expense__c - prop.Monthly_Insurance__c - prop.Monthly_Utilities__c) * 12 / prop.Initial_Investment__c * 100;
            } else if (prop.Initial_Investment__c != null) {
                prop.ROI__c = (prop.Monthly_Rent__c - prop.Monthly_Rental_Expense__c - prop.Monthly_Insurance__c) * 12 / prop.Initial_Investment__c * 100;
            } else {
                prop.ROI__c = null;
            }
        }
    }
}