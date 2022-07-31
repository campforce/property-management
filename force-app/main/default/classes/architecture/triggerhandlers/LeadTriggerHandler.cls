public class LeadTriggerHandler extends TriggerHandler {

    private List<Lead> newLeadList;
    private List<Lead> oldLeadList;
    private Map<Id, Lead> newLeadMap;
    private Map<Id, Lead> oldLeadMap;

    public LeadTriggerHandler() {
        this.newLeadList = (List<Lead>) Trigger.new;
        this.oldLeadList = (List<Lead>) Trigger.old;
        this.newLeadMap = (Map<Id, Lead>) Trigger.newMap;
        this.oldLeadMap = (Map<Id, Lead>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        LeadService.updateLeadStatus(newLeadList);
    }

    public override void afterInsert() {
        LeadService.createTaskLead(newLeadList);
    }
}