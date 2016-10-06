public with sharing class FSObjectController {
	private class ProcessDescriptor {
		public FSProcess fsProcess;
		public FSSerializer fsSerializer;
		public FSDeserializer2 fsDeserializer;
		public String objectType;
	}
	
    @AuraEnabled
    public static String getObject(String objectType, String relatedTo, Id objectId, Id processId, Map<String, String> params) {
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		    			
		// get business object
		FSObjectDTO result = pd.fsProcess.getObject(pd.objectType, objectId);		
								  	
		// serialize result
		return pd.fsSerializer.serialize(result);    	
    }
    
     @AuraEnabled
    public static String getObjects(String objectType, String relatedTo, Id processId, Map<String, String> params) {
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		    		    			
		// get business objects
		List<FSObjectDTO> result = pd.fsProcess.getObjects(objectType);    	

		// serialize result
		return pd.fsSerializer.serialize(result);    	
    }
    
    @AuraEnabled
    public static String createObject(String objectType, String relatedTo, Id processId, Map<String, String> params, String content) {    
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		    		    			
		// convert the blob to an apex class
		FSObjectDTO fsObject = pd.fsDeserializer.deserialize(objectType, content);

		// create business objects
		FSObjectDTO result = pd.fsProcess.createObject(pd.objectType, fsObject);
		
		// serialize result
		return pd.fsSerializer.serialize(result);    	
    }
    
    @AuraEnabled
    public static String updateObject(String objectType, String relatedTo, Id objectID, Id processId, Map<String, String> params, String content) {    
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		
		// convert the blob to an apex class
		FSObjectDTO fsObject = pd.fsDeserializer.deserialize(objectType, content);
		    		    			
		// update business objects
		FSObjectDTO result = pd.fsProcess.updateObject(pd.objectType, objectId, fsObject);
		
		// serialize result
		return pd.fsSerializer.serialize(result);    	
    }
        
    @AuraEnabled
    public static void deleteObject(String objectType, String relatedTo, Id objectId, Id processId, Map<String, String> params) {
		// build the process object
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType, processId, params);
		    		    			
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
			if (params != null) {
				settings.add(params);
			}
			
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
			     	
			descriptor.fsDeserializer = (FSDeserializer2) fsDeserializerType.newInstance();
			
		return descriptor;
	}   
    
    
}