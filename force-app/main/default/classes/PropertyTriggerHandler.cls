public class PropertyTriggerHandler extends TriggerHandler {
    
    private List<Property__c> newPropertyList;
    private List<Property__c> oldPropertyList;
    private Map<Id, Property__c> newPropertyMap;
    private Map<Id, Property__c> oldPropertyMap;

    public PropertyTriggerHandler() {
        this.newPropertyList = (List<Property__c>) Trigger.new;
        this.oldPropertyList = (List<Property__c>) Trigger.old;
        this.newPropertyMap = (Map<Id, Property__c>) Trigger.newMap;
        this.oldPropertyMap = (Map<Id, Property__c>) Trigger.oldMap;
    }

    
    public override void beforeUpdate(){
      PropertyService.IncomeCalculator(newPropertyList);
    }

    public override void beforeInsert(){
        PropertyService.IncomeCalculator(newPropertyList);
    }
}