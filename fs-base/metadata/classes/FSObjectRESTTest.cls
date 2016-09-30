@isTest
public class FSObjectRESTTest {
    public static FSProcessSettings settings;

    public static Process_Instance__c pi1;
    
    public class TestObject implements FSObjectDTO {
    	
    }
    
    public class TestProcess implements FSProcess {
    	
    	public void configure(FSProcessSettings sets) {
    		FSObjectRESTTest.settings = sets;		
    	}
    	
    	public List<FSObjectMetadata> getObjectMetadata() {
    		return null;
    	}     	
    	
		public FSObjectDTO getObject(String objectType, Id objectId) {
			return new TestObject();
		}

		public List<FSObjectDTO> getObjects(String objectType) {
			System.debug('TestProcess:getObjects() ' + objectType);
			if (objectType == 'User') {
				List<FSLookupDTO> users = new List<FSLookupDTO>();
				
				users.add(new FSLookupDTO(UserInfo.getUserId(), UserInfo.getName()));
				
				return users;
			} else if (objectType == 'testobject') {
				return new List<TestObject> {new TestObject()};
			} else {
				throw new FSProcessDataException('Unsupported object type: ' + objectType);
			}
			
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
    
    public class TestSerializer implements FSSerializer {
		public String serialize(List<FSObjectDTO> objs) {
			return JSON.serialize(objs);
		}
		
		public String serialize(FSObjectDTO obj) {
			return JSON.serialize(obj);
		}    	
    }
    
    public class TestDeserializer implements FSDeserializer {
    	public FSObjectDTO deserialize(String objectType, Blob content) {
    		return (FSObjectDTO) JSON.deserialize(content.toString(), TestObject.class);
    	}
    }
    
	
	private static void setup() {
        pi1 = new Process_Instance__c(Label__c = 'test', Order__c = 0, Process__c = 'Test Process');
        insert pi1;		
        
        FSProcessRegister.register('Test Process', 'fsBase', 'FSObjectRESTTest.TestProcess', 'FSObjectRESTTest.TestDeserializer', 'FSObjectRESTTest.TestSerializer', 'TestComponent', new List<String> {'testobject'}, true);
        FSProcessRegister.saveRegistered();
	}
	
	static testMethod void testConfigreProcessWithoutProcessInstance() {
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject';
        
        FSObjectREST.get();
        
        System.assertEquals(200, RestContext.response.statusCode);

        System.assertEquals(2, settings.size());			
        System.assertEquals(UserInfo.getUserId(), settings.get('subjectUserId'));			
        System.assertEquals('testobject', settings.get('objectType'));			
	}
	
	static testMethod void testConfigreProcessWithProcessInstance() {
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject';
        RestContext.request.addParameter(FSProcessSettings.PROCESS_ID_KEY, pi1.Id);
        
        FSObjectREST.get();
        
        System.assertEquals(200, RestContext.response.statusCode);

        System.assertEquals(3, settings.size());			
        System.assertEquals(pi1.Id, settings.get(FSProcessSettings.PROCESS_ID_KEY));			
	}
	
    static testMethod void testGetObjectsWithoutProcessInstance() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject';
        
        FSObjectREST.get();
        
        System.assertEquals(200, RestContext.response.statusCode);

        List<TestObject> result = (List<TestObject>) JSON.deserialize(RestContext.response.responseBody.toString(), List<TestObject>.class);
            
        System.assertEquals(1, result.size());
    }

    static testMethod void testGetSingleObject() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject/'+UserInfo.getUserId();
        
        FSObjectREST.get();
        
        System.assertEquals(200, RestContext.response.statusCode);
        
        TestObject result = (TestObject) JSON.deserialize(RestContext.response.responseBody.toString(), TestObject.class);
        
        System.assert(result != null);            
    }

    static testMethod void testGetObjectsWithProcessInstance() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject';
        RestContext.request.addParameter(FSProcessSettings.PROCESS_ID_KEY, pi1.Id);
        
        FSObjectREST.get();
        
        System.assertEquals(200, RestContext.response.statusCode);
        
        List<TestObject> result = (List<TestObject>) JSON.deserialize(RestContext.response.responseBody.toString(), List<TestObject>.class);
        
         System.assertEquals(1, result.size());
    }

    static testMethod void testCreateObject() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'POST';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject/';
        RestContext.request.requestBody = Blob.valueOf(JSON.serialize(new TestObject()));
        
        FSObjectREST.post();
        
        System.assertEquals(200, RestContext.response.statusCode);

        TestObject result = (TestObject) JSON.deserialize(RestContext.response.responseBody.toString(), TestObject.class);
    }
    
    static testMethod void testUpdateObject() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'PUT';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject/'+UserInfo.getUserId();
        RestContext.request.requestBody = Blob.valueOf(JSON.serialize(new TestObject()));
        
        FSObjectREST.put();
        
        TestObject result = (TestObject) JSON.deserialize(RestContext.response.responseBody.toString(), TestObject.class);
        
        System.assertEquals(200, RestContext.response.statusCode);
    }
    
    static testMethod void testDeleteObject() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'DELETE';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/testobject/'+UserInfo.getUserId();
        RestContext.request.requestBody = Blob.valueOf(JSON.serialize(new TestObject()));
        
        FSObjectREST.deleteObject();
                
        System.assertEquals(200, RestContext.response.statusCode);
    }
    
    static testMethod void testGetRelatedObjects() {       
        setup();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/object/User';
        RestContext.request.addParameter('relatedTo', 'testobject');
        
        FSObjectREST.get();
        
        System.assertEquals(200, RestContext.response.statusCode);

        List<FSLookupDTO> result = (List<FSLookupDTO>) JSON.deserialize(RestContext.response.responseBody.toString(), List<FSLookupDTO>.class);
            
        System.assertEquals(1, result.size());
        System.assertEquals(UserInfo.getUserId(), result.get(0).id);
        System.assertEquals(UserInfo.getName(), result.get(0).name);
    }
}