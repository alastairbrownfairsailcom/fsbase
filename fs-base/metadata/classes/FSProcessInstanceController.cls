public with sharing class FSProcessInstanceController {
    public Process_Instance__c pi {get; set;}

    public final ApexPages.StandardController stdCtrl;

    public FSProcessInstanceController(ApexPages.StandardController stdCtrl) {
    
        this.pi = (Process_Instance__c)stdCtrl.getRecord();

        if (ApexPages.currentpage().getparameters().get('id') != null) {
        
            this.pi = [SELECT Active__c, CreatedById, CreatedDate, IsDeleted, End_Date__c, Label__c, LastModifiedById, LastModifiedDate, Order__c, OwnerId, Process__c, Name, Id, Start_Date__c, SystemModstamp, Additional_Information__c FROM Process_Instance__c WHERE Id = :ApexPages.currentpage().getparameters().get('id')];               
               
        } else {
			this.pi = new Process_Instance__c();           
        }       
    }

    public List<SelectOption> getProcessList() {        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--None--'));
                
        for (FSProcessRegister.RegisteredProcess proc : FSProcessRegister.getAllProcesses()) {
        	options.add(new SelectOption(proc.name, proc.name)); 
        }
        
        options.sort();
        return options;
    }
    
    public pageReference cancelMethod() {
        PageReference pageRef = new PageReference('/'+apexpages.currentpage().getparameters().get('id'));
        pageRef.setRedirect(true);
        return pageRef;                           
     }            
              
    public pageReference insertMethod() {
        if (this.pi.Process__c == '') {
            this.pi.Process__c = null;
        }
                        
        try {
        	upsert pi;        
        } catch(Exception e){
            ApexPages.addmessages(e);
            
            return null;
        }
        
        PageReference pageRef = new PageReference('/'+pi.Id);
        pageRef.setRedirect(true);
        return pageRef;            
	}     

    public Boolean getCheckProcess() {
        boolean msg;
        if(apexpages.currentpage().getparameters().get('id') != null) {
            msg = false;
        } else {
            msg = true;
        }
       
        return msg;
    }
}