({
    makeCurrencyValue: function(component, event){
        let method = component.get("c.convertsCurrency");

        method.setParams({
            valueCurr: component.get('v.selectedCurrency')
        });

        method.setCallback(this, function(datas) {
            component.set("v.currency", datas.getReturnValue());
        });

        $A.enqueueAction(method);
    },

    showOptions: function(component, event) {
        let action = component.get('c.getCurrencies');

        action.setCallback(this,function(data){
            component.set("v.currencyOptions",data.getReturnValue());
        });
        $A.enqueueAction(action);
    },

    getPrice : function(component){
        let prices = component.get("v.selectedPrice");
        let scaleCurrency = 1;
        let abbreviationCurrency;
        let rateCurrency = 1;
        let currencyValue = component.get("v.currency");
        for(let item = 0; item<currencyValue.length; item++){
            if(currencyValue[item].Name == component.get("v.selectedCurrency") ){
                scaleCurrency = currencyValue[item].Scale__c;
                rateCurrency = currencyValue[item].OfficialRate__c;
                abbreviationCurrency = currencyValue[item].Currenccy_Abbreviation__c;
            }
        }
        return (prices * rateCurrency) / scaleCurrency;
    },

    changePrice : function(component,event){
        let searchPrice = this.getPrice(component);

        let action = component.get('c.getProducts');

        action.setParams({
            namePart: component.get("v.namePart"),
            price: searchPrice
        });

        action.setCallback(this, function(data) {
            let scaleCurrency;
            let abbreviationCurrency;
            let rateCurrency;
            let currencyValue = component.get("v.currency");
            let productValue= data.getReturnValue();
            for(let item = 0; item<currencyValue.length; item++){
                if(currencyValue[item].Name == component.get("v.selectedCurrency") ){
                    scaleCurrency = currencyValue[item].Scale__c;
                    rateCurrency = currencyValue[item].OfficialRate__c;
                    abbreviationCurrency = currencyValue[item].Currenccy_Abbreviation__c;
                }
            }
            for(let item = 0; item<productValue.length; item++){
                productValue[item].Price__c = (productValue[item].Price__c * scaleCurrency) / rateCurrency;
                productValue[item].Currency_Name__c = component.get("v.selectedCurrency");
                productValue[item].Currenccy_Abbreviation__c = abbreviationCurrency;
            }
            component.set("v.receivedProducts", productValue);
      });
        $A.enqueueAction(action);
    },
})