({
    doInit : function(component, event, helper) {
    },
    handleProcessListAvailableEvent : function(component, event, helper) {
        var processes = event.getParam("processes");
        
        component.set("v.processes", processes);
    }
})