public class RESTUtilities {
	
	public class URLException extends Exception {}
	
	public static String getPathValue( Integer index ) {
		List<String> urlParts = RestContext.request.requestURI.split('\\?');
		List<String> pathParts = urlParts.get(0).split('/');
		System.debug('Path parts = ' + pathParts);
		return pathParts.size()>index ? pathParts[index] : null;
	}
	
	public static String getPathEnd() {
        return RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1);
	}
	
	public static Decimal getVersion() {
		try {
			String version = GetPathValue(2);
			if (version.removeStart('v').length()>0) {
				return Decimal.valueOf(version.removeStart('v'));
			} else {
				return null;
			}
		} catch (Exception e) {
       		throw new URLException('Invalid version number format' );
		} 
	}
		
	public static String getQueryTerm(String term) {
		String result = RestContext.request.params.get(term);

		if (result != null) {
			result = EncodingUtil.urlDecode(result, 'UTF-8');			
		}
		
		if (result != null && result.length() > 0 && result != 'null' && result != 'undefined') {
			return result;
		} else {
			return null;
		}
	}	
	
	public static Map<String, String> getAllQueryTerms() {
		Map<String, String> params = new Map<String, String>();
		// strip out empty keys
		for (String key : RestContext.request.params.keySet()) {
			String value = RestContext.request.params.get(key);
			if (value != null) {
				value = EncodingUtil.urlDecode(value, 'UTF-8');			
			}
			
			if (value.length() > 0 && value != 'null' && value != 'undefined') {
				params.put(key, value);
			}
		}
		return params;
	}	
	
}