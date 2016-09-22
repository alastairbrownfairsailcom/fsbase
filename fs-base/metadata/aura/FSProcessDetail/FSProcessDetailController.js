({    
	handleProcessSelectedEvent : function(cmp, event) {
        console.log('got process selected event');
        var process = event.getParam("process");
        
        console.log('got process selected event for ' + process.displayName);
                
        cmp.set("v.process", process);
        
        console.log('creating component ' + process.componentName);
        $A.createComponent(process.componentName, 
                           {process: process}, 
                           function (fsProcess, status, errorMessage) {
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    console.log("Component created");
                    cmp.set("v.body", fsProcess);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
             
        });
        
	}
})