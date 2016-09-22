global class ShoutOutProcess implements fsbase.FSProcess {
	private Id subjectUserId;
	private Boolean given;
	
	global void configure(fsbase.FSProcessSettings settings) {
		if (settings != null) {
			if (settings.contains(fsbase.FSProcessSettings.SUBJECT_USER_ID_KEY)) {
				subjectUserId = Id.valueOf(settings.get(fsbase.FSProcessSettings.SUBJECT_USER_ID_KEY));
			} else {
				throw new fsbase.FSProcessConfigException(fsbase.FSProcessSettings.SUBJECT_USER_ID_KEY + ' is null'); 
			}
		
			if (settings.contains('given')) {
				given = Boolean.valueOf(settings.get('given'));
			} else {
				given = false;
			}
		} else {
			throw new fsbase.FSProcessConfigException('settings is null');
		}		
	}
	
	global List<fsbase.FSObjectMetadata> getObjectMetadata() {		
		fsbase.FSObjectMetadata objectMetadata = new fsbase.FSObjectMetadata();
		
		Schema.DescribeSObjectResult objectDescribe = Schema.getGlobalDescribe().get(FSNamespace.prependNamespace('Shout_Out__c')).getDescribe();
		
		objectMetadata.objectType = FSNamespace.prependNamespace('Shout_Out__c');
		objectMetadata.displayName = objectDescribe.getLabel();
		
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(FSNamespace.prependNamespace('Shout_Out__c')).getDescribe().fields.getMap();
		
		
        Schema.SObjectField field = fieldMap.get('Reason__c');       
        if (field != null) {
            DescribeFieldResult dfr = field.getDescribe();
            
			System.debug(dfr);
			
            // found field
            fsbase.FSObjectMetadata.FSPicklistFieldMetadata fieldMetadata = new fsbase.FSObjectMetadata.FSPicklistFieldMetadata();
            fieldMetadata.path = dfr.getName();
            fieldMetadata.displayName = dfr.getLabel();
            fieldMetadata.fieldType = Schema.DisplayType.PICKLIST.name();
            
            if(dfr.getType() == Schema.DisplayType.PICKLIST){
                List<SelectOption> options = new List<SelectOption>();
                SelectOption defaultOption;
                for(Schema.PicklistEntry p : dfr.getPickListValues()) {
                    SelectOption option = new SelectOption(p.getValue(), p.getLabel());
                    options.add(option);
                        
                    if (p.isDefaultValue()) {
                        defaultOption = option;
                    }
                }
                                    
                for (SelectOption option : options) { 
                    if (option.getLabel() == null) {
                    	throw new fsbase.FSProcessDataException('no label');
                    }
					fsbase.FSObjectMetadata.FSPicklistOption opt = new fsbase.FSObjectMetadata.FSPicklistOption(option.getValue(), option.getLabel(), option == defaultOption);
                    if (opt.displayName == null) {
                    	throw new fsbase.FSProcessDataException('no displayName');
                    }
                    fieldMetadata.addOption(opt);
                }               
            }
                
			objectMetadata.addField(fieldMetadata);
        } else {
            throw new fsbase.FSProcessDataException('No field found');
        }	
        			
		return new List<fsbase.FSObjectMetadata> {objectMetadata};
	} 	
	
	global List<fsbase.FSObjectDTO> getObjects(String objectType) {
		if (objectType == null || objectType == 'ShoutOut') {
			if (given == true) {
				return ShoutOut.getAllGivenBy(subjectUserId);
			} else {
				return ShoutOut.getAllReceivedBy(subjectUserId);
			}
		} else if (objectType == 'User') {
			List<FSLookupDTO> users = new List<FSLookupDTO>();
			 	
			for (User user : [SELECT Id, Name FROM User WHERE Id != : UserInfo.getUserId() AND IsActive = true]) {
				users.add(new FSLookupDTO(user.Id, user.Name));
			}
				
			return users;
		} else if (objectType == 'Opportunity') {
			List<FSLookupDTO> opportunities = new List<FSLookupDTO>();
			 	
			for (Opportunity opportunity : [SELECT Id, Name FROM Opportunity WHERE Account.OwnerId =: UserInfo.getUserId() AND LastModifiedDate >= : System.today().addMonths(-3)]) {
				opportunities.add(new FSLookupDTO(opportunity.Id, opportunity.Name));
			}
				
			return opportunities;
		} else {
			return null;
		}
	}
	
	global fsbase.FSObjectDTO getObject(String objectType, Id objectId) {
		return ShoutOut.get(objectId);
	}
	
	global fsbase.FSObjectDTO createObject(String objectType, fsbase.FSObjectDTO obj) {
		return ShoutOut.create((ShoutOut) obj);
	}
	
	global fsbase.FSObjectDTO updateObject(String objectType, Id objectId, fsbase.FSObjectDTO obj) {
		throw new fsBase.FSProcessDataException('Unsupported operation');
	}
	
	global void deleteObject(String objectType, Id objectId) {
		throw new fsbase.FSProcessDataException('Unsupported operation');
	}	
}