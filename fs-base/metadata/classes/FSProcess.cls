global interface FSProcess {
	void configure(FSProcessSettings settings);
	List<FSObjectMetadata> getObjectMetadata(); 

	List<FSObjectDTO> getObjects(String objectType);
	FSObjectDTO getObject(String objectType, Id objectId);
	FSObjectDTO createObject(String objectType, FSObjectDTO obj);
	FSObjectDTO updateObject(String objectType, Id objectId, FSObjectDTO obj);
	void deleteObject(String objectType, Id objectId);
}