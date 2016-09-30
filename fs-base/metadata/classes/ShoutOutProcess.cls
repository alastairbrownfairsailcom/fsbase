public class ShoutOutProcess implements FSProcess {
	private Boolean given = false;
	
	public void configure(FSProcessSettings settings) {
		given = (settings.get('given') == 'true');
	}
	
	public List<FSObjectMetadata> getObjectMetadata() {
		fsbase.FSObjectMetadata objectMetadata = new fsbase.FSObjectMetadata();
				
		objectMetadata.objectType = 'ShoutOut';
		objectMetadata.displayName = 'Shout Out';

            // found field
            fsbase.FSObjectMetadata.FSPicklistFieldMetadata fieldMetadata = new fsbase.FSObjectMetadata.FSPicklistFieldMetadata();
            fieldMetadata.path = 'fsbase__Reason__c';
            fieldMetadata.displayName = 'Reason';
            fieldMetadata.fieldType = Schema.DisplayType.PICKLIST.name();
            
            fieldMetadata.addOption(new FSObjectMetadata.FSPicklistOption('Good Work', 'Good Work', false));
            fieldMetadata.addOption(new FSObjectMetadata.FSPicklistOption('Team Work', 'Team Work', false));
                    
			objectMetadata.addField(fieldMetadata);

		
		return new List<fsbase.FSObjectMetadata> {objectMetadata};		
	}

	public List<FSObjectDTO> getObjects(String objectType) {
		List<FSObjectDTO> objects = new List<FSObjectDTO>();
		
        if (objectType == 'ShoutOut') {
		objects.add(new ShoutOut('Shout Out 1 ' + (given ? 'given' : 'received')));
		objects.add(new ShoutOut('Shout Out 2 ' + (given ? 'given' : 'received')));
		objects.add(new ShoutOut('Shout Out 3 ' + (given ? 'given' : 'received')));
        } else if (objectType == 'User') {
			objects.add(new FSLookupDTO(UserInfo.getUserId(), UserInfo.getName()));
        } else if (objectType == 'Opportunity') {
			objects.add(new FSLookupDTO(null, 'Op1'));            
			objects.add(new FSLookupDTO(null, 'Op2'));            
			objects.add(new FSLookupDTO(null, 'Op3'));            
        }		
		return objects;
	}
	
	public FSObjectDTO getObject(String objectType, Id objectId) {
		return null;
	}
	
	public FSObjectDTO createObject(String objectType, FSObjectDTO obj) {
		return null;
	}
	
	public FSObjectDTO updateObject(String objectType, Id objectId, FSObjectDTO obj) {
		return null;
	}
	
	public void deleteObject(String objectType, Id objectId){
		
	}   
}