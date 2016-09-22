@isTest
public class FSProcessRESTTest {
    public static Process_Instance__c pi1;
	
    public class TestProcess implements FSProcess {
       	public void configure(FSProcessSettings sets) {
    	}
    	
    	public List<FSObjectMetadata> getObjectMetadata() {
    		return new List<FSObjectMetadata> {new FSObjectMetadata()};
    	}     	
    	
		public FSObjectDTO getObject(String objectType, Id objectId) {
			return null;			
		}

		public List<FSObjectDTO> getObjects(String objectType) {
			return null;			
		}
		
		public FSObjectDTO createObject(String objectType, FSObjectDTO obj) {
			return obj;
		}
		   	
		public FSObjectDTO updateObject(String objectType, Id objectId, FSObjectDTO obj) {
			return obj;
		}
		   	
		public void deleteObject(String objectType, Id objectId) {
		} 		  	
    }

	private static void setup() {
        pi1 = new Process_Instance__c(Label__c = 'test', Order__c = 0, Process__c = 'Test Process');
        insert pi1;		
        
        FSProcessRegister.register('Test Process', 'fsBase', 'FSProcessRESTTest.TestProcess', 'TBC', 'TBC', 'Test Component', new List<String> {'testobject'}, true);
        FSProcessRegister.saveRegistered();
	}
	
    static testMethod void testGetAllProcesses() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process';
        
        FSProcessREST.get();
        
        List<FSProcessDTO> result = (List<FSProcessDTO>) JSON.deserialize(RestContext.response.responseBody.toString(), List<FSProcessDTO>.class);
        
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(1, result.size());
        System.assertEquals(pi1.Id, result.get(0).id);
        System.assertEquals(pi1.Process__c, result.get(0).processName);
        System.assertEquals(pi1.Label__c, result.get(0).displayName);
        System.assertEquals('Test Component', result.get(0).componentName);
        
        System.assertEquals(1, result.get(0).objects.size());
    }
    
    static testMethod void testGetProcessById() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process/' +pi1.Id;
        
        FSProcessREST.get();
        
        FSProcessDTO result = (FSProcessDTO) JSON.deserialize(RestContext.response.responseBody.toString(), FSProcessDTO.class);
        
        System.assertEquals(200, RestContext.response.statusCode);
        System.assertEquals(pi1.Id, result.id);
        System.assertEquals(pi1.Process__c, result.processName);
        System.assertEquals(pi1.Label__c, result.displayName);
        System.assertEquals('Test Component', result.componentName);
        
        System.assertEquals(1, result.objects.size());
    }
}