({
    handleGiven : function(component, objects) {
            console.log("Given " + objects.length + " shout out objects");
            
            component.set("v.given", objects);                                                
    },
    handleReceived : function(component, objects) {
            console.log("Received " + objects.length + " shout out objects");
                                
            component.set("v.received", objects);                                                
    }
})