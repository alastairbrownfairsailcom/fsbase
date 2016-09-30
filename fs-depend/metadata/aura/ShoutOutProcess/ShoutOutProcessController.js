({
    doInit : function(component, event, helper) {
        console.log('ShoutOutProcess: doInit');
        
        var objectType = component.get("v.process.objects[0].objectType");
        
                console.log('Getting ' + objectType);
        
         helper.getObjects(component, 
                          objectType,
                          null,
                          component.get("v.process.id"),
                          {
                          	"given": 'true'
                          },
                          function (objects) {helper.handleGiven(component, objects);});
          helper.getObjects(component, 
                          objectType,
                          null,
                          component.get("v.process.id"),
                          {
                          },
                            function (objects) {helper.handleReceived(component, objects);});                  
    },
    handleShoutOutSelectedEvent: function (component, event, helper) {
        	var shoutOut = event.getParam("shoutOut");
            
            console.log("Received " + shoutOut.id);
                                
            component.set("v.selectedShoutOut", shoutOut);                                                        
    },
    handleCreateObjectEvent: function (component, event, helper) {
        console.log('ShoutOutProcess: handleCreateObjectEvent');
                
         var object = event.getParam("object");
        
         helper.createObject(component, 
                          component.get("v.process.objects[0].objectType"),
                          null,
                          component.get("v.process.id"),
                          {},
                          function (object) {helper.handleCreated(component, object);},
                          object);
 
    },
    handleGetObjectsEvent : function (component, event, helper) {
        console.log('handleGetObjectsEvent');
        
        var objectType = event.getParam("objectType");
        var relatedTo = event.getParam("relatedTo");
        
         helper.getObjects(component, 
                          objectType,
                          relatedTo,
                          component.get("v.process.id"),
                          {},
                          function (objects) {helper.handleGetObjects(component, objects, objectType);});
        
    },
    createShoutOut : function (component, event, helper) {
        component.set("v.selectedShoutOut", undefined);
    }
    
})