global class FSObjectMetadata {
	global virtual class FSFieldMetadata {
		@AuraEnabled
		global String path;
		@AuraEnabled
		global String displayName;
		@AuraEnabled
		global String fieldType;
	}
	
	global class FSPicklistOption {
		@AuraEnabled
		global String value {get; private set;}
		@AuraEnabled
		global String displayName {get; private set;}
		@AuraEnabled
		global Boolean isDefault {get; private set;}
		
		global FSPicklistOption(String value, String displayName, Boolean isDefault) {
			this.value = value;
			this.displayName = displayName;
			this.isDefault = isDefault;
		}
	}
	
	global class FSPicklistFieldMetadata extends FSFieldMetadata {
		@AuraEnabled
		global List<FSPicklistOption> options {get; private set;}
		
		global void addOption(FSPicklistOption option) {
			if (options == null) {
				options = new List<FSPicklistOption>();
			}
			
			options.add(option);	
		}		
	}
	
	@AuraEnabled
	global String objectType;
	@AuraEnabled
	global String displayName;
	@AuraEnabled
	global List<FSFieldMetadata> fields {get; private set;}
	@AuraEnabled
	global List<FSObjectMetadata> children {get; private set;}
	
	global void addfield(FSFieldMetadata field) {
		if (fields == null) {
			fields = new List<FSFieldMetadata>();
		}
		
		fields.add(field);	
	}
	
	global void addChild(FSObjectMetadata child) {
		if (children == null) {
			children = new List<FSObjectMetadata>();
		}
		
		children.add(child);	
	}
}