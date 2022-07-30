public with sharing class CaseService {

    /**
     * Method send Email feedback-survey on Case 'Closed'
     * 
     * @param newCases new inserted cases
     * @author gulzatbaimyrzaeva
     */
    public static void sendEmailSurvey(List<Case> newCases) {
        for (Case singleCase : newCases) {
            if (singleCase.Status == 'Closed') {
                if (String.isBlank(singleCase.SuppliedEmail)) {
                    singleCase.addError('Please fill in the Web email');
                }
                EmailService.send(singleCase.SuppliedEmail, singleCase.ContactId);
            }
        }
    }
}
