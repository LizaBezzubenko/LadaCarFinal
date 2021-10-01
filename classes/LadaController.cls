public with sharing class LadaController {
    @AuraEnabled(Cacheable=true)
    public static List<Cars_Center__c> getCenters() {
        return [SELECT Id, Name, City__c, Street__c, 
                    Country__c, Center_Type__c
                FROM Cars_Center__c];
    }
    
}