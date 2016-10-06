public class ShoutOutDeserializer implements FSDeserializer2 {
	public FSObjectDTO deserialize(String objectType, String content) {
		return (FSObjectDTO) JSON.deserialize(content, ShoutOut.class);
	}  
}