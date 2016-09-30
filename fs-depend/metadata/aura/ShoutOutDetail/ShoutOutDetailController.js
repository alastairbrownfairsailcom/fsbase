({
    doInit : function (component, event, helper) {
        component.set("v.newShoutOut", {});

        // get users to give recognition to
        var compEvent = component.getEvent("getObjectsEvent");
		compEvent.setParams({ "objectType" : "User" });
		compEvent.setParams({ "relatedTo" : "ShoutOut" });
		compEvent.fire();
        
        console.log('fired get objects event (Users)');

        // get opportunities for recognition
        var compEvent = component.getEvent("getObjectsEvent");
		compEvent.setParams({ "objectType" : "Opportunity" });
		compEvent.setParams({ "relatedTo" : "ShoutOut" });
		compEvent.fire();
        
        console.log('fired get objects event (Opportunities)');
        
        // get the reasons
        // v.process.objects[0].objectType
        var process = component.get("v.process");
        var fields = process.objects[0].fields;

        for (var field in fields) {
            if (field.path == "FsDepend__Reason__c") {
                component.set("v.reasons", field.options);
            }
        }
        
    },
    createShoutOut : function(component, event, helper) {
        var compEvent = cmp.getEvent("creatObjectEvent");
		compEvent.setParams({ "object" : component.get("v.newShoutOut") });
		compEvent.fire();
        
        console.log('fired create object event');
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
        
	}
})