({
    doInit : function(component, event, helper) {
        component.set("v.showList", true);
        component.set("v.showDetail", false);
        component.set("v.showCreate", false);
    },
    handleShoutOutSelectedEvent: function (component, event, helper) {
        	var shoutOut = event.getParam("shoutOut");
            
            console.log("Received " + shoutOut.id);
                                
            component.set("v.selectedShoutOut", shoutOut);
        
        component.set("v.showList", false);
        component.set("v.showDetail", true);
        component.set("v.showCreate", false);
    },
    showList: function (component, event, helper) { 
        component.set("v.showList", true);
        component.set("v.showDetail", false);
        component.set("v.showCreate", false);
    },
    handleObjectCreatedEvent: function (component, event, helper) { 
        component.set("v.showList", true);
        component.set("v.showDetail", false);
        component.set("v.showCreate", false);
        
        var shoutOut = event.getParam("object");
		// lookup list
		var list = component.find('ShoutOutList');
        list.shoutOutCreated(shoutOut);
    },
    createShoutOut : function (component, event, helper) {
        component.set("v.showList", false);
        component.set("v.showDetail", false);
        component.set("v.showCreate", true);
    }
    
})