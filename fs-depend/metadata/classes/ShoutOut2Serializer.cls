global class ShoutOut2Serializer implements fsbase.FSSerializer {
	global String serialize(List<fsbase.FSObjectDTO> objs) {
		return new ShoutOutSerializer().serialize(objs);
	}
	
	global String serialize(fsbase.FSObjectDTO obj) {
		return new ShoutOutSerializer().serialize(obj);
	}
}