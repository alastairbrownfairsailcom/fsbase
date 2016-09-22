({
	selectProcess : function (p) {
        var appEvent = $A.get("e.fsbase:FSProcessSelectedEvent");
		appEvent.setParams({ "process" : p });
		appEvent.fire();
        
        console.log('fired process selected event');
        
    }})