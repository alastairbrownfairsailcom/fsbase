public class ProcessHelper {
	public static Map<String, String> parseAdditionalInfo(String additionalInfo) {
		if (additionalInfo != null) {
	        Map<String, String> additionalInformation = new Map<String, String>();
	        
	        String separator = '\r\n';
	        if (!additionalInfo.contains(separator)) {
	        	separator = '\n';
	        }
	        String[] sections = additionalInfo.split(separator);
		        for (String section : sections) {
		        	System.debug('Additional property ' + section);
		        	String[] parts = section.split('=');
		        	if (parts.size() == 2) {
			        	additionalInformation.put(parts[0].trim(), parts[1].trim());
		        	} else {
		        		System.debug('Invalid key value pair');
		        	}
		        }
		        
		        return additionalInformation;
	    } else {
	    	System.debug('No additional information');
	    	
	    	return null;
	    }
	}
}