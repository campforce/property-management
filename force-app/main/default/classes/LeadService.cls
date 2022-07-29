public with sharing class LeadService {
 /**
     * Method updates the Lead status. When Lead sourse='Partner Referral' the Lead rating updates to='Hot'
     * 
     * @param newLead new inserted leads 
     * @author gulzatbaimyrzaeva 
     */

    public static void updateLeadStatus (list<Lead>newLead){
    for (Lead l: newLead){
        if(l.LeadSource == 'Partner Referral'){
            l.rating='Hot';
}
    }
}

 /**
     * Method create related task. Logic:
     *  Hot → Create a task with Subject 'Contact in 24 hours',
     *  Warm → Create a task with Subject 'Contact in 48 hours',
    *   Cold → Create a task with Subject 'Contact in 72 hours'.
     * 
     * @param lstTaskToInsert new inserted tasks
     * @author malikaaidarova
     */

 public static void createTaskLead (list<Lead> lstNew){
    list<Task> lstTaskToInsert = new list<Task>();
    for(Lead CreateTask: lstNew){
        if(CreateTask.Rating == 'Hot')
        {
            Task tsk = new Task(WhoId = CreateTask.ID, subject = 'Contact in 24 hours', Description = 'Big Alert', priority = 'High');
            lstTaskToInsert.add(tsk);
        }
        else if(CreateTask.Rating == 'Warm')
        {
            Task tsk = new Task(WhoId = CreateTask.ID, subject = 'Contact in 48 hours', Description = 'Alert', priority = 'Medium');
            lstTaskToInsert.add(tsk);
        }
        else if(CreateTask.Rating == 'Cold')
        {
            Task tsk = new Task(WhoId = CreateTask.ID, subject = 'Contact in 72 hours', Description = 'Alert', priority = 'Low');
            lstTaskToInsert.add(tsk);
        }
        
    }
    insert lstTaskToInsert;

 }

} 