({
    doInit : function(component, event, helper) {
        var action = component.get("c.getProcesses");

        action.setParams({
            "params": {}
        });

        action.setCallback(component, function(a) {
            var result = a.getReturnValue();
            
            console.log('got ' + result.length + ' processes');
            
            // emit the results in a component event
            var compEvent = component.getEvent("fsProcessListAvailableEvent");
            // Optional: set some data for the event (also known as event shape)
            compEvent.setParams({"processes" : result });
            compEvent.fire();            
        });
        $A.enqueueAction(action);
    }
})