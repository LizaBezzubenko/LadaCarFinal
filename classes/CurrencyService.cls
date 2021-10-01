public with sharing class CurrencyService {

    public static List<Currency__c> get() {
        return CurrencyManager.getCurrencies();
    }

    public static Currency__c get(String valueCurr) {
        return CurrencyManager.getCurrencyWithKey(valueCurr);
    }
}