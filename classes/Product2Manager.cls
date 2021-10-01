public with sharing class Product2Manager {

    public static List<Product2> get(String namePart, Decimal price) {

        List<Product2> products = new List<Product2>();
        if (String.isNotBlank(namePart) && price != null) {
            products = [
                    SELECT Id,
                            Name,
                            Year__c,
                            Price__c,
                            Description,
                            Currenccy_Abbreviation__c,
                            URLImage__c
                    FROM Product2
                    WHERE Name LIKE:namePart
                    AND Price__c <= :price
                    AND isActive = true
                    LIMIT 10
            ];
        }
        return products;
    }

    public static List<Product2> get() {

        List<Product2> products = [
                SELECT Id,
                        Name,
                        Year__c,
                        Price__c,
                        Description,
                        Currenccy_Abbreviation__c,
                        Currency_Name__c,
                        URLImage__c
                FROM Product2
                WHERE isActive = true
        ];
        return products;
    }

    public static void updateProduct(List<Product2> products) {
        update products;
    }
}