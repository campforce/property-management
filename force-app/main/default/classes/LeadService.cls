public with sharing class LeadService {

    /**
     * Method updates the Lead status. When Lead sourse='Partner Referral' the Lead rating updates to='Hot'
     * 
     * @param newLead new inserted leads 
     * @author gulzatbaimyrzaeva 
     */
    public static void updateLeadStatus(List<Lead>newLead) {
        for (Lead l : newLead) {
            if (l.LeadSource == 'Partner Referral') {
                l.Rating = 'Hot';
            }
        }
    }

    /**
     * Method create related task. Logic:
     *  Hot → Create a task with Subject 'Contact in 24 hours',
     *  Warm → Create a task with Subject 'Contact in 48 hours',
     *  Cold → Create a task with Subject 'Contact in 72 hours'.
     * 
     * @param lstNew new inserted tasks
     * @author malikaaidarova
     */
    public static void createTaskLead(List<Lead> lstNew) {
        List<Task> lstTaskToInsert = new List<Task>();
        for (Lead CreateTask : lstNew) {
            if (CreateTask.Rating == 'Hot') {
                Task tsk = new Task(WhoId = CreateTask.Id, Subject = 'Contact in 24 hours', Description = 'Big Alert', Priority = 'High');
                lstTaskToInsert.add(tsk);
            } else if (CreateTask.Rating == 'Warm') {
                Task tsk = new Task(WhoId = CreateTask.Id, Subject = 'Contact in 48 hours', Description = 'Alert', Priority = 'Medium');
                lstTaskToInsert.add(tsk);
            } else if (CreateTask.Rating == 'Cold') {
                Task tsk = new Task(WhoId = CreateTask.Id, Subject = 'Contact in 72 hours', Description = 'Alert', Priority = 'Low');
                lstTaskToInsert.add(tsk);
            }
        }
        insert lstTaskToInsert;
    }
} 