({
	selectShoutOut : function (cmp, so) {
        var compEvent = cmp.getEvent("shoutOutSelectedEvent");
		compEvent.setParams({ "shoutOut" : so });
		compEvent.fire();
        
        console.log('fired shout out selected event');
        
    }})