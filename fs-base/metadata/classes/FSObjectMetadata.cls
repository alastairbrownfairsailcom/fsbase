global class FSObjectMetadata {
	global virtual class FSFieldMetadata {
		@Deprecated // no need to deprecate now object are serialized by object controller instead of lightning
		global String path;
		@Deprecated
		global String displayName;
		@Deprecated
		global String fieldType;
		
		public String getPath() {
			return path;
		}
		
		public void setPath(String path) {
			this.path = path;
		}
		
		public String getDisplayName() {
			return displayName;
		}
		
		public void setDisplayName(String displayName) {
			this.displayName = displayName;
		}
		
		public String getFieldType() {
			return fieldType;
		}
		
		public void setFieldType(String fieldType) {
			this.fieldType = fieldType;
		}
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
		global String path {get {return super.getPath();} set {super.setPath(value);}}
		@AuraEnabled
		global String displayName {get {return super.getDisplayName();} set {super.setDisplayName(value);}}
		@AuraEnabled
		global String fieldType {get {return super.getFieldType();} set {super.setFieldType(value);}}
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