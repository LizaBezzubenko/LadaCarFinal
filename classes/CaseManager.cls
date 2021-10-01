public with sharing class CaseManager {

    public static final String ORIGIN_WEB = 'Web';
    public static final String REASON_FINANCIAL_CLAIM = 'Financial Claim';
    public static final String PRIORITY_MEDIUM = 'Medium';
    public static final String PRIORITY_HIGH = 'High';

    public static List<Case> getCaseByOrigin() {

        List<Case> cases = [
                SELECT Id,
                        Reason,
                        Priority
                FROM Case
                WHERE Origin = :ORIGIN_WEB
                WITH SECURITY_ENFORCED
        ];

        return cases;
    }

    public static void updateCase(List<Case> cases) {
        if (!Schema.SObjectType.Case.fields.Priority.isUpdateable()) {
            update cases;
        }
    }
}