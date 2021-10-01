public with sharing class CurrencyManager {

    public static List<Currency__c> getCurrencies() {

        List<Currency__c> currencies = [
                SELECT Id,
                        Name,
                        Currenccy_Abbreviation__c,
                        Scale__c,
                        OfficialRate__c
                FROM Currency__c
        ];
        return currencies;
    }

    public static Currency__c getCurrencyWithKey(String valueCurr) {

        Currency__c searchCurrency = [
                SELECT Id, Name,
                        Currenccy_Abbreviation__c,Scale__c,
                        OfficialRate__c
                FROM Currency__c
                WHERE Name = :valueCurr
        ];
        return searchCurrency;
    }
    public static void updateCurrency(List<Currency__c> currencies) {
        // if (!Schema.SObjectType.Currency__c.fields.OfficialRate__c.isUpdateable()) {
        update currencies;
        //  }
    }


}