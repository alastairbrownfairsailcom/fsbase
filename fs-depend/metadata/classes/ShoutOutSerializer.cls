public class ShoutOutSerializer implements fsbase.FSSerializer {
	public String serialize(List<fsbase.FSObjectDTO> objs) {
		return JSON.serialize(objs);
	}
	
	public String serialize(fsbase.FSObjectDTO obj) {
		return JSON.serialize(obj);
	}
}