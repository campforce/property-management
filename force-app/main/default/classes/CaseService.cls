public with sharing class CaseService {
/**
 * Method Implements Email sending feedback-survey logic on Case
 * This Email contains button, which will redirect to Google form. 
 * 
 * @param newCase new inserted Case
 * @param emailSurvey class to send email
 * @author gulzatbaimyrzaeva 
 */
public static void emailSurveyButton (list<Case> newCase){
    for(Case cs:newCase){
        if(cs.Status=='Closed')
        emailSurvey.send(cs.Status);
    }
}

}
