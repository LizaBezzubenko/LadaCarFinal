({
    doInit : function(component, event, helper) {
        helper.makeCurrencyValue(component,event);
        helper.showOptions(component,event);
        helper.getPrice(component,event);
        helper.changePrice(component,event);
    },

    findProduct: function(component, event, helper) {
        helper.makeCurrencyValue(component,event);
        helper.changePrice(component,event);
    },
})