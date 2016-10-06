({
    handleGetObjects : function(component, objects, objectType) {
        console.log("Got " + objects.length + " "+objectType+" objects");

        if (objectType == "User") {
            component.set("v.users", objects); 
        } else if (objectType == "Opportunity") {
            component.set("v.opportunities", objects); 
        } 
    },
    handleCreated : function(component, object) {
    var compEvent = component.getEvent("objectCreatedEvent");
		compEvent.setParams({ "object" : object });
		compEvent.fire();
        
        console.log('fired object created event');
        
        // clear create form
        component.set("v.newShoutOut", {});
        
         var receiverComponent = component.find("receiver");
         receiverComponent.set("v.value", "");
        
         var opportunityComponent = component.find("opportunity");
         opportunityComponent.set("v.value", "");
        
         var reasonComponent = component.find("reason");
         reasonComponent.set("v.value", "");        
    }
})