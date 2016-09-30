@RestResource(urlMapping='/*/fs/object/*/*')
global class FSObjectREST {
	private class ProcessDescriptor {
		public FSSerializer fsSerializer;
		public FSDeserializer fsDeserializer;
		public String objectType;
		public String relatedTo;
	}
	
	@HttpGet
	global static void get() {
		String dto = null;
		
		try {
		    Id objectId;
		    try {
		    	objectId = Id.valueOf(RESTUtilities.getPathValue(6)); 
		    } catch (Exception ex) {
		    	// no object so get list
		    }
		    
		    System.debug('Object id: ' + objectId);
		    
		    ProcessDescriptor pd = buildProcess();
			
			if (objectId != null) {
				// get business object
				FSObjectDTO obj = FSObjectController.getObject(pd.objectType, pd.relatedTo, objectId, RESTUtilities.getQueryTerm(FSProcessSettings.PROCESS_ID_KEY), RestUtilities.getAllQueryTerms());				
						
				// serialize business objects
				dto = pd.fsSerializer.serialize(obj);	
			} else {
				// get business objects
				List<FSObjectDTO> objects = FSObjectController.getObjects(pd.objectType, pd.relatedTo, RESTUtilities.getQueryTerm(FSProcessSettings.PROCESS_ID_KEY), RestUtilities.getAllQueryTerms());				
						
				// serialize business objects
				dto = pd.fsSerializer.serialize(objects);	
			}		
		} catch (Exception ex) {
			System.debug(ex);
			System.debug(ex.getStackTraceString());
		}	

        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse;
	    if (dto != null) {
	        res.statusCode = 200;
	        jsonResponse = dto;
	    } else {
	        res.statusCode = 400;
          	jsonResponse = '{"response": {"status": "Failure", "message": "Failed to build object"}}';
	    }
	        
		res.responseBody = blob.valueOf(jsonResponse);	            	        			
	} 
	  
	@HttpPost
	global static void post() {
		String dto = null;
						
		try {
			// build the process object
		    ProcessDescriptor pd = buildProcess();
			
			// convert request body
			Blob body = RestContext.request.requestBody;
			
			// deserialize business objects			
			FSObjectDTO fsObject = pd.fsDeserializer.deserialize(pd.objectType, body);
			
			// create object
			FSObjectDTO result = FSObjectController.createObject(pd.objectType, pd.relatedTo, RESTUtilities.getQueryTerm(FSProcessSettings.PROCESS_ID_KEY), RestUtilities.getAllQueryTerms(), fsObject);
									
			// serialize business objects
			dto = pd.fsSerializer.serialize(result);			
												
		} catch (Exception ex) {
			System.debug(ex);
			System.debug(ex.getStackTraceString());
		}	

        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse;
	    if (dto != null) {
	        res.statusCode = 200;
	        jsonResponse = dto;
	    } else {
	        res.statusCode = 400;
          	jsonResponse = '{"response": {"status": "Failure", "message": "Failed to create object"}}';
	    }
	        
		res.responseBody = blob.valueOf(jsonResponse);	            	        			
	}   
	  
	@HttpPut
	global static void put() {
		String dto = null;
						
		try {
			// build the process object
		    ProcessDescriptor pd = buildProcess();

		    Id objectId = Id.valueOf(RESTUtilities.getPathValue(6)); 
			
			// convert request body
			Blob body = RestContext.request.requestBody;
			
			// deserialize business objects			
			FSObjectDTO fsObject = pd.fsDeserializer.deserialize(pd.objectType, body);
			
			// update object
			FSObjectDTO result = FSObjectController.updateObject(pd.objectType, pd.relatedTo, objectId, RESTUtilities.getQueryTerm(FSProcessSettings.PROCESS_ID_KEY), RestUtilities.getAllQueryTerms(), fsObject);
						
			// serialize business objects
			dto = pd.fsSerializer.serialize(result);			
												
		} catch (Exception ex) {
			System.debug(ex);
			System.debug(ex.getStackTraceString());
		}	

        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse;
	    if (dto != null) {
	        res.statusCode = 200;
	        jsonResponse = dto;
	    } else {
	        res.statusCode = 400;
          	jsonResponse = '{"response": {"status": "Failure", "message": "Failed to create object"}}';
	    }
	        
		res.responseBody = blob.valueOf(jsonResponse);	            	        			
	}   
	  
	@HttpDelete
	global static void deleteObject() {		
		Boolean ok = true;				

		try {
		    Id objectId = Id.valueOf(RESTUtilities.getPathValue(6)); 

		    ProcessDescriptor pd = buildProcess();
			
			// delete object
			FSObjectController.deleteObject(pd.objectType, pd.relatedTo, objectId, RESTUtilities.getQueryTerm(FSProcessSettings.PROCESS_ID_KEY), RestUtilities.getAllQueryTerms());												
		} catch (Exception ex) {
			System.debug(ex);
			System.debug(ex.getStackTraceString());
			
			ok = false;
		}	

        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse;
	    if (ok) {
	        res.statusCode = 200;
	    } else {
	        res.statusCode = 400;
          	jsonResponse = '{"response": {"status": "Failure", "message": "Failed to delete object"}}';
	    }
	      
	    if (jsonResponse != null) {  
			res.responseBody = blob.valueOf(jsonResponse);
	    }	            	        			
	}
	
	private static ProcessDescriptor buildProcess() {					    
		// are we getting related objects
		String relatedTo = RESTUtilities.getQueryTerm('relatedTo');
		String objectType = RESTUtilities.getPathValue(5);			
		
		System.debug('Related to: ' + relatedTo);
						
		ProcessDescriptor pd = buildProcess(relatedTo != null ? relatedTo : objectType);
		
		// save primary and related object types
		pd.objectType = objectType;
		pd.relatedTo = relatedTo;
		
		return pd;
	}
	
	private static ProcessDescriptor buildProcess(String objectType) {
		if (objectType == null) {
		    throw new FSObjectException('Object type is null');
		}
		
		// create process composite
		ProcessDescriptor descriptor = new ProcessDescriptor();
				
			// lookup process
			FSProcessRegister.RegisteredProcess registeredProcess = FSProcessRegister.getProcessByObjectType(objectType);
				
			if (registeredProcess == null) {
		       	throw new FSProcessInstanceException('Object does not match a process: ' + objectType); 
			}			
					
			// get serializer
			Type fsSerializerType = Type.forName(registeredProcess.namespace, registeredProcess.serializerClassName);
			     	
			descriptor.fsSerializer = (FSSerializer) fsSerializerType.newInstance();

			// get Deserializer
			Type fsDeserializerType = Type.forName(registeredProcess.namespace, registeredProcess.deserializerClassName);
			     	
			descriptor.fsDeserializer = (FSDeserializer) fsDeserializerType.newInstance();
			
		return descriptor;
	}   
}