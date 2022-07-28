public with sharing class CaseService {
    
    /**
     * Method Implements Email sending feedback-survey logic on Case
     * This Email contains button, which will redirect to Google form. 
     * 
     * @param newCase new inserted cases
     * @author gulzatbaimyrzaeva 
     */
    public static void sendEmailSurvey(List<Case> newCases){
        for(Case singleCase : newCases){
            if(singleCase.Status == 'Closed') {
                EmailService.send(singleCase.Status);
            }
        }
    }
}
