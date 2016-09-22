public with sharing class FSObjectController {
	private class ProcessDescriptor {
		public FSProcess fsProcess;
		public FSSerializer fsSerializer;
		public FSDeserializer fsDeserializer;
		public String objectType;
	}
	
    @AuraEnabled
    public static FSObjectDTO getObject(String objectType, String relatedTo, Id objectId, Id processId, Map<String, String> params) {
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		    			
		// get business object
		return pd.fsProcess.getObject(pd.objectType, objectId);								  	
    }
    
     @AuraEnabled
    public static List<FSObjectDTO> getObjects(String objectType, String relatedTo, Id processId, Map<String, String> params) {
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		    		    			
		// get business objects
		return pd.fsProcess.getObjects(objectType);    	
    }
    
    @AuraEnabled
    public static FSObjectDTO createObject(String objectType, Id processId, Map<String, String> params, FSObjectDTO fsObject) {
		// build the process object
		ProcessDescriptor pd = buildProcess(objectType, processId, params);
		    		    			
		// create business objects
		return pd.fsProcess.createObject(pd.objectType, fsObject);    	
    }
    
    @AuraEnabled
    public static FSObjectDTO updateObject(String objectType, Id objectId, Id processId, Map<String, String> params, FSObjectDTO fsObject) {
		// build the process object
		ProcessDescriptor pd = buildProcess(objectType, processId, params);
		    		    			
		// update business objects
		return pd.fsProcess.updateObject(pd.objectType, objectId, fsObject);    	
    }
        
    @AuraEnabled
    public static void deleteObject(String objectType, Id objectId, Id processId, Map<String, String> params) {
		// build the process object
		ProcessDescriptor pd = buildProcess(objectType, processId, params);
		    		    			
		// delete business objects
		pd.fsProcess.deleteObject(pd.objectType, objectId);    	
    }
        
	private static ProcessDescriptor buildProcess(String objectType, Id processId, Map<String, String> params) {
		if (objectType == null) {
		    throw new FSObjectException('Object type is null');
		}
		
		// create process composite
		ProcessDescriptor descriptor = new ProcessDescriptor();
		
		// save primary object type
		descriptor.objectType = objectType;
		
			// lookup process
			FSProcessRegister.RegisteredProcess registeredProcess = FSProcessRegister.getProcessByObjectType(objectType);
				
			if (registeredProcess == null) {
		       	throw new FSProcessInstanceException('Object does not match a process: ' + objectType); 
			}			
			
			// construct process class
			Type fsProcessType = Type.forName(registeredProcess.namespace, registeredProcess.className);        	
			
			descriptor.fsProcess = (FSProcess) fsProcessType.newInstance();
			
			FSProcessSettings settings = new FSProcessSettings();
			
			// add the primary object type to the query
			settings.add(FSProcessSettings.OBJECT_TYPE_KEY, objectType);
			
			if (processId != null) {   			
				// lookup process details
		        Process_Instance__c instance = [SELECT Id, Name, Label__c, Start_Date__c, End_Date__c, Active__c, Process__c, Order__c, Additional_Information__c FROM Process_Instance__c WHERE id = :processId LIMIT 1];
		        
		        if (instance.Active__c != true) {
		        	throw new FSProcessInstanceException('Process instance is not active');
		        }
		        
		        Date today = System.today();
		        if (instance.Start_Date__c != null && instance.Start_Date__c > today) {
		        	throw new FSProcessInstanceException('Process instance has not started: ' + instance.Start_Date__c);
		        }
				
		        if (instance.End_Date__c != null && instance.End_Date__c < today) {
		        	throw new FSProcessInstanceException('Process instance has fnished: ' + instance.End_Date__c);
		        }
		        
		        if (instance.Additional_Information__c != null) {
		        	settings.add(ProcessHelper.parseAdditionalInfo(instance.Additional_Information__c));
		        }
		        
		        settings.add(FSProcessSettings.PROCESS_ID_KEY, processId);		        
			}
			
			// add query params to the config
			settings.add(params);
			
			if (!settings.contains(FSProcessSettings.SUBJECT_USER_ID_KEY)) {
				settings.add(FSProcessSettings.SUBJECT_USER_ID_KEY, UserInfo.getUserId());
			}
			
			// configure the process
			descriptor.fsProcess.configure(settings);
		
			// get serializer
			Type fsSerializerType = Type.forName(registeredProcess.namespace, registeredProcess.serializerClassName);
			     	
			descriptor.fsSerializer = (FSSerializer) fsSerializerType.newInstance();

			// get Deserializer
			Type fsDeserializerType = Type.forName(registeredProcess.namespace, registeredProcess.deserializerClassName);
			     	
			descriptor.fsDeserializer = (FSDeserializer) fsDeserializerType.newInstance();
			
		return descriptor;
	}   
    
    
}