public with sharing class ChartController {

    /**
     * Method for chart component
     *
     * @return Map<String, Integer> where key is PropertyType, value is count of specific Type
     * @author kushtar
     */
    @AuraEnabled(Cacheable=true)
    public static Map<String, Integer> getStatistics() {
        Map<String, Integer> dataset = new Map<String, Integer>();

        for (AggregateResult record : [SELECT Property_Type__c, COUNT(Id) Total FROM Property__c GROUP BY Property_Type__c]) {
            dataset.put((String) record.get('Property_Type__c'), (Integer) record.get('Total'));
        }
        return dataset;
    }
}
