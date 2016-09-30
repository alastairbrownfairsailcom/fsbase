({
    handleGiven : function(component, objects) {
            console.log("Given " + objects.length + " shout out objects");
            
            component.set("v.given", objects);                                                
    },
    handleReceived : function(component, objects) {
            console.log("Received " + objects.length + " shout out objects");
                                
            component.set("v.received", objects);                                                
    },
    handleCreated : function (component, object) {
        console.log("Created " + object.id);

        // refresh list
        var objects = component.get("v.given");
        objects.push(object);
        component.set("v.given", objects);                                                
    },
    handleGetObjects : function(component, objects, objectType) {
        console.log("Got " + objects.length + " "+objectType+" objects");
        console.log(objects[0].name);
        if (objectType == "User") {
            component.set("v.users", objects); 
        } else if (objectType == "Opportunity") {
            component.set("v.opportunities", objects); 
        } 
    },
})