public class FSProcessDTO {
	@AuraEnabled
	public Id id {get; private set;}
	@AuraEnabled
	public String processName {get; private set;}
	@AuraEnabled
	public String displayName {get; private set;}
	@AuraEnabled
	public String componentName {get; private set;}
	@AuraEnabled
	public List<FSObjectMetadata> objects {get; private set;}
	
	public static FSProcessDTO create(Id id, String processName, String displayName, String componentName, List<FSObjectMetadata> objects) {
		FSProcessDTO dto = new FSProcessDTO();
		
		dto.id = id;
		dto.processName = processName;
		dto.displayName = displayName;
		dto.componentName = componentName;
		dto.objects = objects;
		
		return dto;
	}

}