global class ShoutOut2Deserializer implements fsbase.FSDeserializer2 {
	global fsbase.FSObjectDTO deserialize(String objectType, String content) {
		if (content == null) {
			return null;			
		}
		
		if (objectType == 'ShoutOut2') {
			return new ShoutOutDeserializer().deserialize(objectType, content);
		}
		
		throw new fsBase.FSProcessDataException('Unknown object type: ' + objectType);
	}
}