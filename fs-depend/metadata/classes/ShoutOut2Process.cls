global class ShoutOut2Process implements fsbase.FSProcess {
	private ShoutOutProcess proc;
	
	global ShoutOut2Process() {
		proc = new ShoutOutProcess();
	}
	
	global void configure(fsbase.FSProcessSettings settings) {
		if (settings.get(fsbase.FSProcessSettings.OBJECT_TYPE_KEY) == 'ShoutOut2') {
			settings.add(fsbase.FSProcessSettings.OBJECT_TYPE_KEY, 'ShoutOut');	
		}	
		
		proc.configure(settings);		
	}
	
	global List<fsbase.FSObjectMetadata> getObjectMetadata() {
		return proc.getObjectMetadata();		
	} 	
	
	global List<fsbase.FSObjectDTO> getObjects(String objectType) {
		if (objectType == 'ShoutOut2') {
			objectType = 'ShoutOut';	
		}
			
		return proc.getObjects(objectType);
	}
	
	global fsbase.FSObjectDTO getObject(String objectType, Id objectId) {
		if (objectType == 'ShoutOut2') {
			objectType = 'ShoutOut';	
		}
			
		return proc.getObject(objectType, objectId);
	}
	
	global fsbase.FSObjectDTO createObject(String objectType, fsbase.FSObjectDTO obj) {
		if (objectType == 'ShoutOut2') {
			objectType = 'ShoutOut';	
		}
			
		return proc.createObject(objectType, obj);
	}
	
	global fsbase.FSObjectDTO updateObject(String objectType, Id objectId, fsbase.FSObjectDTO obj) {
		if (objectType == 'ShoutOut2') {
			objectType = 'ShoutOut';	
		}
			
		return proc.updateObject(objectType, objectId, obj);
	}
	
	global void deleteObject(String objectType, Id objectId) {
		if (objectType == 'ShoutOut2') {
			objectType = 'ShoutOut';	
		}
			
		proc.deleteObject(objectType, objectId);
	}	
}