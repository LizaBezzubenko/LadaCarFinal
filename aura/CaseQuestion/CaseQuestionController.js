({
   handleSuccess : function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "success",
            "title": "Case Created",
            "message": "Your question sent!"
        });
    },
        
   handleReset: function(cmp, event, helper) {
        cmp.find('field').forEach(function(f) {
            f.reset();
        });
    }
})