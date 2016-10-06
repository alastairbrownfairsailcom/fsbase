global class FSProcessRegister {
	public class RegisteredProcess {
		public String name {get; private set;}
		public String namespace {get; private set;}
		public String className {get; private set;}		
		public String componentName {get; private set;}		
		public String deserializerClassName {get; private set;}		
		public String serializerClassName {get; private set;}		
	}
	
	private static List<FS_Process__c> processesToRegister;
	private static List<FS_Process_Object__c> processObjectsToRegister;
	private static List<FS_Process_Object__c> processObjectsToUnregister;
	
	global static void register(String name, String namespace, String processClassName, String deserializerClassName, String serializerClassName, String componentName, List<String> objectNames, Boolean overwrite) {
		if (processesToRegister == null) {
			processesToRegister = new List<FS_Process__c>();
		}
		
		if (processObjectsToRegister == null) {
			processObjectsToRegister = new List<FS_Process_Object__c>();
		}
		
		if (processObjectsToUnregister == null) {
			processObjectsToUnregister = new List<FS_Process_Object__c>();
		}
		
		// see if already registered
		FS_Process__c item = FS_Process__c.getInstance(name);
		
		if (item == null) {
			item = new FS_Process__c(
				Name = name, 
				Package_Namespace__c = namespace, 
				Process_Class__c = processClassName,
				Deserializer_Class__c = deserializerClassName,
				Serializer_Class__c = serializerClassName,
				Component__c = componentName 
				);
		} else if (overwrite) {
			item.Package_Namespace__c = namespace;
			item.Process_Class__c = processClassName;
			item.Deserializer_Class__c = deserializerClassName;
			item.Serializer_Class__c = serializerClassName;
			item.Component__c = componentName;
			
			processObjectsToUnregister.add([SELECT Name, Process_Name__c FROM FS_Process_Object__c WHERE Process_Name__c =: name]);
		}
					
		for (String objectName : objectnames) {
			processObjectsToRegister.add(new FS_Process_Object__c(Name = objectName, Process_Name__c = name));
		}
		processesToRegister.add(item);	
	}

    global static void saveRegistered() {
    	if (processesToRegister != null) {
	        upsert processesToRegister;
	        delete processObjectsToUnregister;
	        upsert processObjectsToRegister;
	        processesToRegister.clear();
	        processObjectsToRegister.clear();
    	}
    }
    
    private static transient Map<String, RegisteredProcess> registeredProcesses;
    public static RegisteredProcess getProcess(String processName) {
    	if (registeredProcesses == null) {
    		registeredProcesses = new Map<String, RegisteredProcess>();
            List<FS_Process__c> items = FS_Process__c.getAll().values();
            for (FS_Process__c item : items) {
            	RegisteredProcess regProc = new RegisteredProcess();
            	
            	regProc.name = item.Name;
            	regProc.namespace = item.Package_Namespace__c;
            	regProc.className = item.Process_Class__c;
            	regProc.className = item.Process_Class__c;
            	regProc.deserializerClassName = item.Deserializer_Class__c;
            	regProc.serializerClassName = item.Serializer_Class__c;
            	regProc.componentName = item.Component__c;
            	
            	registeredProcesses.put(item.Name, regProc);
            }
    		
    	}
		
		return registeredProcesses.get(processName);
    }
    
    public static List<RegisteredProcess> getAllProcesses() {
    	if (registeredProcesses == null) {
    		registeredProcesses = new Map<String, RegisteredProcess>();
            List<FS_Process__c> items = FS_Process__c.getAll().values();
            for (FS_Process__c item : items) {
            	RegisteredProcess regProc = new RegisteredProcess();
            	
            	regProc.name = item.Name;
            	regProc.namespace = item.Package_Namespace__c;
            	regProc.className = item.Process_Class__c;
            	regProc.className = item.Process_Class__c;
            	regProc.deserializerClassName = item.Deserializer_Class__c;
            	regProc.serializerClassName = item.Serializer_Class__c;
            	regProc.componentName = item.Component__c;
            	
            	registeredProcesses.put(item.Name, regProc);
            }
    		
    	}
		
		return registeredProcesses.values();
    }
    
    global List<String> getAllProcessNames() {
    	List<String> names = new List<String>();
    	for (RegisteredProcess proc : getAllProcesses()) {
    		names.add(proc.Name);
    	}
    	return names;
    }
    
    private static transient Map<String, RegisteredProcess> registeredObjects;
    public static RegisteredProcess getProcessByObjectType(String objectType) {
    	if (registeredObjects == null) {
    		registeredObjects = new Map<String, RegisteredProcess>();
    		
    		List<FS_Process_Object__c> items = FS_Process_Object__c.getAll().values();
            for (FS_Process_Object__c item : items) {
            	registeredObjects.put(item.Name, getProcess(item.Process_Name__c));
            }
    	}
    	
		return registeredObjects.get(objectType);
    }
    
    global static void clear() {
    	List<FS_Process__c> processes = FS_Process__c.getAll().values();
    	List<FS_Process_Object__c> objects = FS_Process_Object__c.getAll().values();
    	
    	delete processes;
    	delete objects;
    }
    
    /*
    public static void registerInbuilt() {
        FSProcessRegister.register('Shout Out Process', 'fsbase', 'ShoutOutProcess', 'ShoutOutDeserializer', 'ShoutOutSerializer', 'ShoutOutProcess', new List<String> {'ShoutOut'}, true);
    	saveRegistered();
    }
    */
}