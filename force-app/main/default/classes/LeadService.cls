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
} 