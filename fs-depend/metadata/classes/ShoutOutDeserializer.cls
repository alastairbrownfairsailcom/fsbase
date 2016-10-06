global class ShoutOutDeserializer implements fsbase.FSDeserializer2 {
	global fsbase.FSObjectDTO deserialize(String objectType, String content) {
		if (content == null) {
			return null;			
		}
		
		if (objectType == 'ShoutOut' || objectType == 'ShoutOut2') {
			return (ShoutOut) JSON.deserialize(content, ShoutOut.class);
		}
		
		throw new fsBase.FSProcessDataException('Unknown object type: ' + objectType);
	}
}