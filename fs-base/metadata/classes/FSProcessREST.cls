@RestResource(urlMapping='/*/fs/process/*')
global class FSProcessREST {
	@HttpGet
	global static void get() {
		String dto = null;
		
		try {
			// get the process id
			Id processId;
			try {
				processId = RESTUtilities.getPathValue(5);
			} catch (StringException ex) {
				System.debug('Process id not found');				
			}
			
			if (processId != null) {   			
				FSProcessDTO piDTO = FSProcessController.getProcess(processId, RestUtilities.getAllQueryTerms());
				
				dto = JSON.serialize(piDTO);
			} else {
				List<FSProcessDTO> dtos = FSProcessController.getProcesses(RestUtilities.getAllQueryTerms());
				
				dto = JSON.serialize(dtos);									
			}
			
		} catch (Exception ex) {
			System.debug(ex);
			System.debug(ex.getStackTraceString());
		}	
		
		System.debug('Response body = ' + dto);
		
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse;
	    if (dto != null) {
	        res.statusCode = 200;   
	        jsonResponse = dto;
	    } else {
	        res.statusCode = 400;
          	jsonResponse = '{"response": {"status": "Failure", "message": "Failed to build process"}}';
	    }
	        
		res.responseBody = blob.valueOf(jsonResponse);	            	        			
	} 
	
	private static FSProcess buildProcess(String processName) {
		if (processName == null) {
		    throw new FSObjectException('processName is null');
		}
				
			// lookup process
			FSProcessRegister.RegisteredProcess registeredProcess = FSProcessRegister.getProcess(processName);
				
			if (registeredProcess == null) {
		       	throw new FSProcessInstanceException('processName does not match a process: ' + processName); 
			}			
			
			// construct process class
			Type fsProcessType = Type.forName(registeredProcess.namespace, registeredProcess.className);        	
			
			FSProcess fsProcess = (FSProcess) fsProcessType.newInstance();
			
			FSProcessSettings settings = new FSProcessSettings();
						
			// add query params to the config
			settings.add(RestUtilities.getAllQueryTerms());
			
			if (!settings.contains(FSProcessSettings.SUBJECT_USER_ID_KEY)) {
				settings.add(FSProcessSettings.SUBJECT_USER_ID_KEY, UserInfo.getUserId());
			}
			
			// configure the process
			fsProcess.configure(settings);
					
		return fsProcess;
	}   
}