({
	getObjects : function(component) {
        var action = component.get("c.getObjects");

        action.setParams({
            "objectType": component.get("v.objectType"),
            "relatedTo": component.get("v.relatedTo"),
            "processId":  component.get("v.processId"),
            "params": component.get("v.params")            
        });

        action.setCallback(component, function(a) {
            var result = a.getReturnValue();
            
            if (result) {
                console.log('got ' + result.length + ' objects');
                
                // emit the results in a component event
                var compEvent = component.getEvent("fsObjectListAvailableEvent");
                // Optional: set some data for the event (also known as event shape)
                compEvent.setParams({"objects" : result });
                compEvent.fire(); 
                
            } else {
                console.log('No objects retrieved');
            }
        });
        $A.enqueueAction(action);		
	}
})