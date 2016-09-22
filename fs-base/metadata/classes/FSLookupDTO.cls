global virtual class FSLookupDTO implements FSObjectDTO {
	global Id id {get; private set;}
	global String name {get; private set;}
	
	global FSLookupDTO(Id id, String name) {
		this.id = id;
		this.name = name;
	}
}