public class CaseTriggerHandler extends TriggerHandler {

    private List<Case> newCaseList;
    private List<Case> oldCaseList;
    private Map<Id, Case> newCaseMap;
    private Map<Id, Case> oldCaseMap;

    public CaseTriggerHandler() {
        this.newCaseList = (List<Case>) Trigger.new;
        this.oldCaseList = (List<Case>) Trigger.old;
        this.newCaseMap = (Map<Id, Case>) Trigger.newMap;
        this.oldCaseMap = (Map<Id, Case>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        CaseService.sendEmailSurvey(newCaseList);
    }

    public override void beforeUpdate() {
        CaseService.sendEmailSurvey(newCaseList);
    }
}