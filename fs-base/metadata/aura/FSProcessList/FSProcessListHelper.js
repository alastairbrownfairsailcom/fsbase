({
	getProcesses : function(component) {
        var action = component.get("c.getProcesses");

        action.setParams({
            "params": {}
        });

        var self = this;
        action.setCallback(this, function(a) {
            var result = a.getReturnValue();
            
            console.log('got ' + result.length + ' processes');
            
            component.set("v.processes", result);
        });
        $A.enqueueAction(action);
	}
})