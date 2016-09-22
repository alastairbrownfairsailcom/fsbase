global class ShoutOutDeserializer implements fsbase.FSDeserializer {
	global fsbase.FSObjectDTO deserialize(String objectType, Blob content) {
		if (content == null) {
			return null;			
		}
		
		if (objectType == 'ShoutOut') {
			return (ShoutOut) JSON.deserialize(content.toString(), ShoutOut.class);
		}
		
		throw new fsBase.FSProcessDataException('Unknown object type: ' + objectType);
	}
}