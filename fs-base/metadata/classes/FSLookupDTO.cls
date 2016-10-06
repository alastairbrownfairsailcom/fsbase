global virtual class FSLookupDTO implements FSObjectDTO {
	@Deprecated // no need to deprecate now object are serialized by object controller instead of lightning
	global Id id {get; private set;}
	@Deprecated
	global String name {get; private set;}
	
	global FSLookupDTO() {}
	
	global virtual Id getId() {
		return id;
	}
	
	global virtual void setId(Id id) {
		this.id = id;
	}

	global virtual String getName() {
		return id;
	}
	
	global virtual void setName(String name) {
		this.name = name;
	}

	@Deprecated
	global FSLookupDTO(Id id, String name) {
		this.id = id;
		this.name = name;
	}
}