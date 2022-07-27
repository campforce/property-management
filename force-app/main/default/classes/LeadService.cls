public with sharing class LeadService {
public static void UpdTriggerLeadStatus (list<Lead>newLead){
    for (Lead l: newLead){
        if(l.LeadSource == 'Partner Referral'){
            l.rating='Hot';
}
    }
}
} 