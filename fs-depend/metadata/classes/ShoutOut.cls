public class ShoutOut implements fsbase.FSObjectDTO {
	public Id id {get; private set;}
	public String typeName {get; private set;}
	public Id receiverId {get; set;}
	public String receiverName {get; set;}
	public Id giverId {get; set;}
	public String giverName {get; set;}
	public Id opportunityId {get; set;}
	public String opportunityName {get; set;}
	public String comments {get; set;}
	public String reason {get; set;}
	
	public static ShoutOut get(Id shoutOutId) {
		ShoutOut so;
		try {
			Shout_Out__c soObj = [SELECT Id, CreatedById, CreatedBy.Name, Receiver__c, Receiver__r.Name, Opportunity__c, Opportunity__r.Name, Comments__c, Reason__c FROM Shout_Out__c WHERE Id =: shoutOutId LIMIT 1];

			so = buildShoutOut(soObj);
		} catch (Exception ex) {
			System.debug(ex);
		}
		
		return so;
	}
	
	public static List<ShoutOut> getAllReceivedBy(Id subjectUserId) {
		List<ShoutOut> sos;
		try {
			List<Shout_Out__c> soObjs = [SELECT Id, CreatedById, CreatedBy.Name, Receiver__c, Receiver__r.Name, Opportunity__c, Opportunity__r.Name, Comments__c, Reason__c FROM Shout_Out__c WHERE Receiver__c =: subjectUserId];

			sos = buildList(soObjs);
		} catch (Exception ex) {
			System.debug(ex);
		}
		
		return sos;		
	}
	
	public static List<ShoutOut> getAllGivenBy(Id subjectUserId) {
		List<ShoutOut> sos;
		try {
			List<Shout_Out__c> soObjs = [SELECT Id, CreatedById, CreatedBy.Name, Receiver__c, Receiver__r.Name, Opportunity__c, Opportunity__r.Name, Comments__c, Reason__c FROM Shout_Out__c WHERE CreatedById =: subjectUserId];

			sos = buildList(soObjs);
		} catch (Exception ex) {
			System.debug(ex);
		}
		
		return sos;		
	}
	
	public static ShoutOut create(ShoutOut so) {
		if (so.receiverId == UserInfo.getUserId()) {
			throw new fsbase.FSProcessDataException('Cannot give to self');
		}
		
		Shout_Out__c soObj = new Shout_Out__c();
		
		soObj.Opportunity__c = so.opportunityId;
		soObj.Receiver__c = so.receiverId;
		soObj.Comments__c = so.comments;
		soObj.Reason__c = so.reason;
		
		insert soObj;
		
		return get(soObj.Id);
	}
	
	private static List<ShoutOut> buildList(List<Shout_Out__c> soObjs) {

			List<ShoutOut> sos = new List<ShoutOut>();
			
			for (Shout_Out__c soObj : soObjs) {
				sos.add(buildShoutOut(soObj));
			}
		return sos;
	}
	
	private static ShoutOut buildShoutOut(Shout_Out__c soObj) {
		ShoutOut so = new ShoutOut();
			
		so.id = soObj.Id;
		so.typeName = ShoutOut.class.getName();
		so.receiverId = soObj.Receiver__c;
		so.receiverName = soObj.Receiver__r.Name;
		so.giverId = soObj.CreatedById;
		so.giverName = soObj.CreatedBy.Name;
		so.opportunityId = soObj.Opportunity__c;
		so.opportunityName = soObj.Opportunity__r.Name;
		so.comments = soObj.Comments__c;
		so.reason = soObj.Reason__c;
		
		return so;
	}	
}