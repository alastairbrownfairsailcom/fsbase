global class ShoutOutSerializer implements fsbase.FSSerializer {
	global String serialize(List<fsbase.FSObjectDTO> objs) {
		return JSON.serialize(objs);
	}
	
	global String serialize(fsbase.FSObjectDTO obj) {
		return JSON.serialize(obj);
	}
}