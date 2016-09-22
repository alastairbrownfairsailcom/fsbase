@isTest
public class FSProcessRegisterTest {
    public static testmethod void testGetAllRegistered() {
        FSProcessRegister.register('Test Process', 'fsBase', 'FSProcessRESTTest.TestProcess', 'TBC', 'TBC', 'Test Component', new List<String> {'testobject'}, true);
        FSProcessRegister.saveRegistered();

    	System.assertEquals('Test Process', FSProcessRegister.getProcess('Test Process').name);
    }
    
    public static testmethod void testGetAllProcesses() {
        FSProcessRegister.register('Test Process', 'fsBase', 'FSProcessRESTTest.TestProcess', 'TBC', 'TBC', 'Test Component', new List<String> {'testobject'}, true);
        FSProcessRegister.saveRegistered();

    	System.assertEquals(1, FSProcessRegister.getAllProcesses().size());
    }
    
    public static testmethod void testClear() {
        FSProcessRegister.register('Test Process', 'fsBase', 'FSProcessRESTTest.TestProcess', 'TBC', 'TBC', 'Test Component', new List<String> {'testobject'}, true);
        FSProcessRegister.saveRegistered();
        
        FSProcessRegister.clear();

    	System.assertEquals(0, FS_Process__c.getAll().values().size());
    }
    
    public static testmethod void testGetUnknown() {
        FSProcessRegister.register('Test Process', 'fsBase', 'FSProcessRESTTest.TestProcess', 'TBC', 'TBC', 'Test Component', new List<String> {'testobject'}, true);
        FSProcessRegister.saveRegistered();

    	System.assert(null == FSProcessRegister.getProcess('Unkown Process'));
    }
}