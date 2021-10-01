public with sharing class CurrencySchedulable implements Schedulable {
    private static final String CUR_ABBREVIATION = 'Cur_Abbreviation';
    private static final String CUR_OFFICIALRATE = 'Cur_OfficialRate';
    private static final String METHOD_GET = 'GET';
    private static final Integer STATUS_200 = 200;
    private static final String HREF_NATBANK = 'https://www.nbrb.by/api/exrates/rates?periodicity=0';

    public static void execute(SchedulableContext sc) {
        changeCurrency();
    }

    private static void changeCurrency() {
        HttpResponse response = makeGetCallout();

        if (response.getStatusCode() == STATUS_200) {
            List<Currency__c> returnedCurrency = getUpdatedCurrency(response);
            CurrencyManager.updateCurrency(returnedCurrency);
        }
    }

    // @future(callout=true)
    private static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(HREF_NATBANK);
        request.setMethod(METHOD_GET);
        HttpResponse response = http.send(request);
        return response;
    }

    private static List<Currency__c> getUpdatedCurrency(HttpResponse response) {
        String stringResponse = response.getBody();
        List<Object> responseResult = (List<Object>) JSON.deserializeUntyped(stringResponse);

        List<Currency__c> currencies = CurrencyManager.getCurrencies();
        Map<String, Currency__c> abbreviationToCurrency = new Map<String, Currency__c>();
        Map<String, Decimal> abbreviationToRate = new Map<String, Decimal>();

        for (Currency__c item : currencies) {
            abbreviationToCurrency.put(item.Currenccy_Abbreviation__c, item);
        }

        for (Object itemObject : responseResult) {

            Map<String, Object> stringToObject = (Map<String, Object>) itemObject;
            String abbreviation = (String) stringToObject.get(CUR_ABBREVIATION);
            Decimal rate = (Decimal) stringToObject.get(CUR_OFFICIALRATE);
            abbreviationToRate.put(abbreviation, rate);
        }

        for (String key : abbreviationToRate.keySet()) {
            if (abbreviationToCurrency.containsKey(key)) {
                Currency__c currencyRecord = abbreviationToCurrency.get(key);
                Decimal currentRate = abbreviationToRate.get(key);
                currencyRecord.OfficialRate__c = currentRate;
            }
        }
        return currencies;
    }
}