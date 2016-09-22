public class FSProcessController {
    @AuraEnabled
    public static FSProcessDTO getProcess(Id processId, Map<String, String> params) {
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
		        	throw new FSProcessInstanceException('Process instance has finished: ' + instance.End_Date__c);
		        }
		        
		        FSProcessRegister.RegisteredProcess regProc = FSProcessRegister.getProcess(instance.Process__c);
		        if (regProc == null) {
		        	throw new FSProcessInstanceException('Process instance has no corresponding process: ' + instance.Process__c);
		        }
								
				// get the metadata associated wiht this process
				FSProcess proc = buildProcess(instance.Process__c, params);
			
		return FSProcessDTO.create(processId, instance.Process__c, instance.Label__c, regProc.componentName, proc.getObjectMetadata());
    }
    
    @AuraEnabled
    public static List<FSProcessDTO> getProcesses(Map<String, String> params) {
    	List<FSProcessDTO> dtos = new List<FSProcessDTO>();
    	
				for (Process_Instance__c instance : [SELECT Id, Name, Label__c, Start_Date__c, End_Date__c, Active__c, Process__c, Order__c, Additional_Information__c FROM Process_Instance__c WHERE Active__c = true AND (Start_Date__c = null OR Start_Date__c <= TODAY) AND (End_Date__c = null OR End_Date__c >= TODAY)]) {
			        FSProcessRegister.RegisteredProcess regProc = FSProcessRegister.getProcess(instance.Process__c);
			        if (regProc == null) {
			        	throw new FSProcessInstanceException('Process instance has no corresponding process: ' + instance.Process__c);
			        }
			        
					// get the metadata associated wiht this process
					FSProcess proc = buildProcess(instance.Process__c, params);
					
					FSProcessDTO piDTO = FSProcessDTO.create(instance.Id, instance.Process__c, instance.Label__c, regProc.componentName, proc.getObjectMetadata());
						
					dtos.add(piDTO);
				}
				
		return dtos;
    }
    
	private static FSProcess buildProcess(String processName, Map<String, String> params) {
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
			settings.add(params);
			
			if (!settings.contains(FSProcessSettings.SUBJECT_USER_ID_KEY)) {
				settings.add(FSProcessSettings.SUBJECT_USER_ID_KEY, UserInfo.getUserId());
			}
			
			// configure the process
			fsProcess.configure(settings);
					
		return fsProcess;
	}   
}