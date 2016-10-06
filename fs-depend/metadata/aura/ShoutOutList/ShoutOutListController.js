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
    shoutOutCreated : function(component, event) {
        var params = event.getParam('arguments');
        if (params) {
            var shoutOut = params.shoutOut;
    
             console.log("Created " + shoutOut.id);
    
            // refresh list
            var given = component.get("v.given");
            given.unshift(shoutOut);
            component.set("v.given", given);
        }
    }
})