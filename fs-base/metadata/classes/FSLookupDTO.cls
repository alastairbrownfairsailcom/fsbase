global virtual class FSLookupDTO implements FSObjectDTO {
	@AuraEnabled
	global Id id {get; private set;}
	@AuraEnabled
	global String name {get; private set;}
	
	global FSLookupDTO(Id id, String name) {
		this.id = id;
		this.name = name;
	}
}