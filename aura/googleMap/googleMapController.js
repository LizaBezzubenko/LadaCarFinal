({
    init: function (cmp, event, helper) {
        let action = cmp.get("c.getCenters"); 
        $A.enqueueAction(action);
        action.setCallback(this, function(response) {
            cmp.set('v.mapMarkers', [
                {              
                    location: {
                        Street: JSON.stringify(response.getReturnValue()[0].Street__c),
                        City: JSON.stringify(response.getReturnValue()[0].City__c),
                        Country: JSON.stringify(response.getReturnValue()[0].Country__c)
                    },         
                    icon: 'utility:salesforce1',
                    title: 'Lada service na chizhovke'
                },
                {              
                    location: {
                        Street: JSON.stringify(response.getReturnValue()[1].Street__c),
                        City: JSON.stringify(response.getReturnValue()[1].City__c),
                        Country: JSON.stringify(response.getReturnValue()[1].Country__c)
                    },         
                    icon: 'utility:salesforce1',
                    title: 'Lada na kamenke'
                },
                {              
                    location: {
                        Street: JSON.stringify(response.getReturnValue()[2].Street__c),
                        City: JSON.stringify(response.getReturnValue()[2].City__c),
                        Country: JSON.stringify(response.getReturnValue()[2].Country__c)
                    },         
                    icon: 'utility:salesforce1',
                    title: 'LADA Minsk Official'
                },
            ]);
        });
        
        cmp.set('v.center', {
            location: {
                City: 'Minsk'
            }
        });

        cmp.set('v.zoomLevel', 11);
        cmp.set('v.markersTitle', 'Lada centers locations in Belarus');
        cmp.set('v.showFooter', true);
    }
});