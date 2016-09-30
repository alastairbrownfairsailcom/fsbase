public class ShoutOutDeserializer implements FSDeserializer {
	public FSObjectDTO deserialize(String objectType, Blob content) {
		return (FSObjectDTO) JSON.deserialize(content.toString(), ShoutOut.class);
	}
    
}