@isTest
public class RESTUtiltiesTest {
	public static testmethod void testPathEnd() {
		RestContext.request = new RestRequest();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process';
        
        System.assertEquals('process', RESTUtilities.getPathEnd());		
	}
    
	public static testmethod void testPathValue() {
		RestContext.request = new RestRequest();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process';
        
        System.assertEquals('process', RESTUtilities.getPathValue(4));		
	}
    
	public static testmethod void testGetVersion() {
		RestContext.request = new RestRequest();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process';
        
        System.assertEquals(1.0, RESTUtilities.getVersion());		
	}
    
	public static testmethod void testGetVersionAsNumber() {
		RestContext.request = new RestRequest();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/1.0/fs/process';
        
        System.assertEquals(1.0, RESTUtilities.getVersion());		
	}
    
	public static testmethod void testGetAllQueryTerms() {
		RestContext.request = new RestRequest();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process';
        RestContext.request.addParameter('term1', 't1');
        RestContext.request.addParameter('term2', 't2');
        
        System.assertEquals(2, RESTUtilities.getAllQueryTerms().size());		
	}
    
	public static testmethod void testGetQueryTerm() {
		RestContext.request = new RestRequest();
        RestContext.request.httpMethod = 'GET';
        RestContext.request.requestURI = '/' + FSNamespace.NAMESPACE + '/v1.0/fs/process?term1=t1,term2=t2';
        RestContext.request.addParameter('term1', 't1');
        RestContext.request.addParameter('term2', 't2');
        
        System.assertEquals('t1', RESTUtilities.getQueryTerm('term1'));		
	}
    
}