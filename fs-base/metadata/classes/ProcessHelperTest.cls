@isTest
public class ProcessHelperTest {
	public static testmethod void testParseAdditionalInfo() {
		Map<String, String> result = ProcessHelper.parseAdditionalInfo('test=me');
		
		System.assertEquals('me', result.get('test'));
	}
	
	public static testmethod void testParseAdditionalInfoIsNull() {
		Map<String, String> result = ProcessHelper.parseAdditionalInfo(null);
		
		System.assert(result == null);
	}
    
}