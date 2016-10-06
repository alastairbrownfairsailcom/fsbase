@isTest(seeAllData=false)
public class ShoutOutProcessTest {
	private static User otherUser;
	private static Opportunity opportunity;
	
	private static void setup() {
		// create another user
        User thisUser = [select TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, LanguageLocaleKey, CompanyName, ProfileId from User where Id=:System.UserInfo.getUserId()];

        otherUser = new User(FirstName='Another', 
        LastName='User', 
        Alias='ano', 
        Email='another@test.com', 
        UserName='fs__other@tests.test.com',
        ProfileId=thisUser.ProfileId,
        TimeZoneSidKey=thisUser.TimeZoneSidKey,
        LocaleSidKey=thisUser.LocaleSidKey,
        EmailEncodingKey=thisUser.EmailEncodingKey,
        LanguageLocaleKey=thisUser.LanguageLocaleKey);
        insert otherUser;     
				
		// create account
		Account acc = new Account(Name='Test Corp', OwnerId = UserInfo.getUserId());
		insert acc;

		// create opportunity
		opportunity = new Opportunity(Name='Op1', StageName='Prospecting', CloseDate=System.today().addDays(30), AccountId = acc.Id);
		insert opportunity;		
	}
	
		
	public static testmethod void testGetShoutOut() {
		setup();
		
		Id selfId = UserInfo.getUserId();
		
		Shout_Out__c so;
		System.runAs(otherUser) {
			so = new Shout_Out__c(
				Receiver__c = selfId,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
			insert so;
		}
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		fsbase.FSObjectDTO result = proc.getObject('ShoutOut', so.Id); 
		
		System.assertEquals(selfId, ((ShoutOut) result).receiverId);	
	}
	
	public static testmethod void testGetShoutOutsReceivedBySelf() {
		setup();
		
		Id selfId = UserInfo.getUserId();
		
		Shout_Out__c soSelf;
		System.runAs(otherUser) {
			soSelf = new Shout_Out__c(
				Receiver__c = selfId,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
			insert soSelf;
		}
		
		Shout_Out__c soOther = new Shout_Out__c(
				Receiver__c = otherUser.Id,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
		insert soOther;
		
		fsbase.FSProcessSettings settings = new fsbase.FSProcessSettings();
		settings.add(fsbase.FSProcessSettings.SUBJECT_USER_ID_KEY, selfId);
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		proc.configure(settings);
		
		List<fsbase.FSObjectDTO> results = proc.getObjects('ShoutOut'); 
		
		System.assertEquals(1, results.size());	
		System.assertEquals(selfId, ((List<ShoutOut>) results).get(0).receiverId);	
		System.assertEquals(soSelf.Id, ((List<ShoutOut>) results).get(0).id);	
	}
	
	public static testmethod void testGetShoutOutsReceivedByOther() {
		setup();
		
		Id selfId = UserInfo.getUserId();
		
		Shout_Out__c soSelf;
		System.runAs(otherUser) {
			soSelf = new Shout_Out__c(
				Receiver__c = selfId,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
			insert soSelf;
		}
		
		Shout_Out__c soOther = new Shout_Out__c(
				Receiver__c = otherUser.Id,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
		insert soOther;
		
		fsbase.FSProcessSettings settings = new fsbase.FSProcessSettings();
		settings.add(fsbase.FSProcessSettings.SUBJECT_USER_ID_KEY, otherUser.Id);
		settings.add('given', 'false');
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		proc.configure(settings);
		
		List<fsbase.FSObjectDTO> results = proc.getObjects('ShoutOut'); 
		
		System.assertEquals(1, results.size());	
		System.assertEquals(otherUser.Id, ((List<ShoutOut>) results).get(0).receiverId);	
		System.assertEquals(soOther.Id, ((List<ShoutOut>) results).get(0).id);	
	}
	
	public static testmethod void testGetShoutOutsGivenBySelf() {
		setup();
		
		Id selfId = UserInfo.getUserId();
		
		Shout_Out__c soSelf;
		System.runAs(otherUser) {
			soSelf = new Shout_Out__c(
				Receiver__c = selfId,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
			insert soSelf;
		}
		
		Shout_Out__c soOther = new Shout_Out__c(
				Receiver__c = otherUser.Id,
				Opportunity__c = opportunity.Id,
				Comments__c = 'a comment'
			);
		
		insert soOther;
		
		fsbase.FSProcessSettings settings = new fsbase.FSProcessSettings();
		settings.add(fsbase.FSProcessSettings.SUBJECT_USER_ID_KEY, selfId);
		settings.add('given', 'true');
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		proc.configure(settings);
		
		List<fsbase.FSObjectDTO> results = proc.getObjects('ShoutOut'); 
		
		System.assertEquals(1, results.size());	
		System.assertEquals(otherUser.Id, ((List<ShoutOut>) results).get(0).receiverId);	
		System.assertEquals(soOther.Id, ((List<ShoutOut>) results).get(0).id);	
	}
	
	public static testmethod void testConfigureWithNullSettings() {
		setup();
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		try {
			proc.configure(null);
			System.assert(false);
		} catch (Exception ex) {
			// expected
		}
	}
	
	public static testmethod void testConfigureWithNoSettings() {
		setup();
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		fsbase.FSProcessSettings settings = new fsbase.FSProcessSettings();

		try {
			proc.configure(settings);
			System.assert(false);
		} catch (Exception ex) {
			// expected
		}
	}
		
	public static testmethod void testCreateShoutOut() {
		setup();
		
		ShoutOut so = new ShoutOut();
		so.receiverId = otherUser.Id;
		so.opportunityId = opportunity.Id;
		so.comments = 'A comment';
		so.reason = 'Just because';
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		fsbase.FSObjectDTO result = proc.createObject('ShoutOut', so); 
		
		System.assertEquals(UserInfo.getUserId(), ((ShoutOut) result).giverId);	
		
		System.assertEquals(1, [SELECT count() FROM Shout_Out__c]);
	}
	
	public static testmethod void testCreateShoutOutForSelf() {
		setup();
		
		ShoutOut so = new ShoutOut();
		so.receiverId = UserInfo.getUserId();
		so.opportunityId = opportunity.Id;
		so.comments = 'A comment';
		so.reason = 'Just because';
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		try {
			fsbase.FSObjectDTO result = proc.createObject('ShoutOut', so); 
			System.assert(false);
		} catch (Exception ex) {
			// expected
		}	
	}
	
	public static testmethod void testObjectMetadata() {
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		List<fsbase.FSObjectMetadata> metadata = proc.getObjectMetadata();
		
		System.assertEquals(1, metadata.size());
		System.assertEquals(1, metadata.get(0).fields.size());
		System.assertEquals('Reason', metadata.get(0).fields.get(0).displayName);
		System.assertEquals(FSNamespace.prependNamespace('Reason__c'), metadata.get(0).fields.get(0).path);
		System.assertEquals('PICKLIST', metadata.get(0).fields.get(0).fieldType);
		
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(FSNamespace.prependNamespace('Shout_Out__c')).getDescribe().fields.getMap();
                
        Schema.SObjectField field = fieldMap.get('Reason__c');
		
		System.assertEquals(field.getDescribe().getPickListValues().size(), ((fsbase.FSObjectMetadata.FSPicklistFieldMetadata) metadata.get(0).fields.get(0)).options.size());
		System.assert(((fsbase.FSObjectMetadata.FSPicklistFieldMetadata) metadata.get(0).fields.get(0)).options.get(0).displayName != null);
		System.assertEquals(field.getDescribe().getPickListValues().get(0).getLabel(), ((fsbase.FSObjectMetadata.FSPicklistFieldMetadata) metadata.get(0).fields.get(0)).options.get(0).displayName);
	}
	
	public static testmethod void testGetReceivers() {
		setup();
		
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		List<fsbase.FSObjectDTO> results = proc.getObjects('User');

		System.assertEquals(2, results.size());	// seems to be getting all users
		Boolean found = false;
		for (FSLookupDTO dto : ((List<FSLookupDTO>) results)) {
			if (dto.id == otherUser.Id) {
				found = true;
			}
		}
		System.assertEquals(true, found);
	}
	
	public static testmethod void testGetOpportunities() {
		setup();
						
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		List<fsbase.FSObjectDTO> results = proc.getObjects('Opportunity');

		System.assertEquals(1, results.size());	
		System.assertEquals(opportunity.Id, ((List<FSLookupDTO>) results).get(0).id);	
	}
	
	public static testmethod void testUpdate() {
		setup();
						
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		try {
			proc.updateObject(null, null, null);
			System.assert(false);
		} catch (Exception ex) {
			// expected
		}		
	}
	
	public static testmethod void testDelete() {
		setup();
						
		fsbase.FSProcess proc = new ShoutOutProcess();
		
		try {
			proc.deleteObject(null, null);
			System.assert(false);
		} catch (Exception ex) {
			// expected
		}		
	}	
}