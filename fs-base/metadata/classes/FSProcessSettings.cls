global class FSProcessSettings {
    global static final String PROCESS_ID_KEY = 'processId';
    global static final String SUBJECT_USER_ID_KEY = 'subjectUserId';
    global static final String RELATED_TO_OBJECT_KEY = 'relatedTo';
    global static final String OBJECT_TYPE_KEY = 'objectType';
        
    private Map<String, String> settings = new Map<String, String>();
    
    global void add(String key, String value) {
    	settings.put(key, value);
    }
    
    global void add(Map<String, String> src) {
    	settings.putAll(src);
    }
    
    global Boolean contains(String key) {
    	return settings.containsKey(key);
    }
    
    global String get(String key) {
    	return settings.get(key);
    }
    
    global Integer size() {
    	return settings.size();
    }
}