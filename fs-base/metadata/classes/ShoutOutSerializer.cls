public class ShoutOutSerializer implements FSSerializer {
	public String serialize(List<FSObjectDTO> objs) {
		return JSON.serialize(objs);
	}
	public String serialize(FSObjectDTO obj) {
		return JSON.serialize(obj);
	}   
}