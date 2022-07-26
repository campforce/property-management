trigger UpdTriggerLeadStatus on Lead (before update) {
        for (Lead l: trigger.new){
            if(trigger.oldMap.get(l.Id).LeadSource == 'Partner Referral'){
                l.rating='Hot';
            }               
    }
    }