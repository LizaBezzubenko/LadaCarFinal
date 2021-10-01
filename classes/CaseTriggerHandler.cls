public with sharing class CaseTriggerHandler {

    public static Boolean checkTrue = true;

    public static void afterInsert() {

        List<Case> cases = CaseManager.getCaseByOrigin();

        for (Case item : cases){
            if (item.Reason == CaseManager.REASON_FINANCIAL_CLAIM) {
                item.Priority = CaseManager.PRIORITY_HIGH;
            } else {
                item.Priority = CaseManager.PRIORITY_MEDIUM;
            }
        }
        CaseManager.updateCase(cases);
    }
}