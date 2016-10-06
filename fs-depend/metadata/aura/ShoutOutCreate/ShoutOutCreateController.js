({
    doInit : function (component, event, helper) {
        component.set("v.newShoutOut", {});
              
        helper.getObjects(component, 
                          "User",
                          "ShoutOut",
                          component.get("v.process.id"),
                          {},
                          function (objects) {helper.handleGetObjects(component, objects, "User");});
        
        helper.getObjects(component, 
                          "Opportunity",
                          "ShoutOut",
                          component.get("v.process.id"),
                          {},
                          function (objects) {helper.handleGetObjects(component, objects, "Opportunity");});
                
        
        // get the reasons
        var process = component.get("v.process");
        var fields = process.objects[0].fields;

        if (fields) {
            fields.forEach(function (field) {
                if (field.path == "FsDepend__Reason__c") {
                    component.set("v.reasons", field.options);
                }
            })
        }        
    },
    createShoutOut : function(component, event, helper) {
        console.log('ShoutOutCreate: createShoutOut');
                        
         helper.createObject(component, 
                          component.get("v.process.objects[0].objectType"),
                          null,
                          component.get("v.process.id"),
                          {},
                          component.get("v.newShoutOut"),
                          function (object) {helper.handleCreated(component, object);}
                          );
	},
	onSelectChange : function(component, event, helper) {
        var newShoutOut = component.get("v.newShoutOut");
        
    	var receiverId = component.find("receiver").get("v.value");
        
        newShoutOut.receiverId = receiverId;
        
        var opportunityId = component.find("opportunity").get("v.value");
                
        newShoutOut.opportunityId = opportunityId;
        
        var reason = component.find("reason").get("v.value");
                
        newShoutOut.reason = reason;
        
        var comments = component.find("comments").get("v.value");
        
        newShoutOut.comments = comments;

        component.set("v.newShoutOut", newShoutOut);

        if (newShoutOut.receiverId && 
            newShoutOut.receiverId != "" && 
            newShoutOut.reason && 
            newShoutOut.reason != "" && 
            newShoutOut.opportunityId && 
            newShoutOut.opportunityId != "") {
        	component.set("v.canCreate", true);
        } else {
        	component.set("v.canCreate", false);
        }  
	}
})