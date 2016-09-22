global interface FSDeserializer {
	FSObjectDTO deserialize(String objectType, Blob content);
}