({
	getObjects : function(component, objectType, relatedTo, processId, params, callback) {
        var action = component.get("c.getObjects");

        action.setParams({
            "objectType": objectType,
            "relatedTo": relatedTo,
            "processId":  processId,
            "params": params            
        });

        action.setCallback(component, function(a) {
            var result = a.getReturnValue();
            
            if (result) {
                console.log('got ' + result.length + ' objects');
                
                callback(result);
            } else {
                console.log('No objects retrieved');
            }
        });
        $A.enqueueAction(action);		
	},
	getObject : function(component, objectType, relatedTo, objectId, processId, params, callback) {
        var action = component.get("c.getObject");

        action.setParams({
            "objectType": objectType,
            "relatedTo": relatedTo,
    		"objectId": objectId,
            "processId":  processId,
            "params": params            
        });

        action.setCallback(component, function(a) {
            var result = a.getReturnValue();
            
            if (result) {
                console.log('got object: ' + result.id);
                
                callback(result);
            } else {
                console.log('No objects retrieved');
            }
        });
        $A.enqueueAction(action);		
	},
	createObject : function(component, objectType, relatedTo, processId, params, object, callback) {
        var action = component.get("c.createObject");

        action.setParams({
            "objectType": objectType,
            "relatedTo": relatedTo,
            "processId":  processId,
            "params": params,
            "fsObject": object
        });

        action.setCallback(component, function(a) {
            var result = a.getReturnValue();
            
            if (result) {
                console.log('got object: ' + result.id);
                
                callback(result);
            } else {
                console.log('No objects retrieved');
            }
        });
        $A.enqueueAction(action);		
	},
	updateObject : function(component, objectType, relatedTo, objectId, processId, params, object, callback) {
        var action = component.get("c.updateObject");

        action.setParams({
            "objectType": objectType,
            "relatedTo": relatedTo,
    		"objectId": objectId,
            "processId":  processId,
            "params": params,
            "fsObject": object
        });

        action.setCallback(component, function(a) {
            var result = a.getReturnValue();
            
            if (result) {
                console.log('got updated object: ' + result.id);
                
                callback(result);
            } else {
                console.log('No object updated');
            }
        });
        $A.enqueueAction(action);		
	},
	deleteObject : function(component, objectType, relatedTo, objectId, processId, params, callback) {
        var action = component.get("c.deleteObject");

        action.setParams({
            "objectType": objectType,
            "relatedTo": relatedTo,
    		"objectId": objectId,
            "processId":  processId,
            "params": params
        });

        action.setCallback(component, function(a) {
            console.log('object deleted');
                
            callback();
        });
        $A.enqueueAction(action);		
	}
})