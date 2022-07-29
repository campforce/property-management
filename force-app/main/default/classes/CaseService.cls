public with sharing class CaseService {
    
    /**
     * Method Implements Email sending feedback-survey logic on Case
     * This Email contains button, which . 
     * 
     * @param newCase new inserted cases
     * @param EmailService sends Email which redirects to Google survey 

     * @author gulzatbaimyrzaeva}
     */
    public static void sendEmailSurvey(List<Case> newCases){
        for(Case singleCase : newCases){
            if(singleCase.Status == 'Closed') {
                if (singleCase.SuppliedEmail ==null){
               singleCase.addError('Please fill in the Web email');
                } 
                EmailService.send(singleCase.SuppliedEmail);      
            }
        }
    }
}