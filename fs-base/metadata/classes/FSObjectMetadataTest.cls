@isTest
public class FSObjectMetadataTest {
	public static testmethod void testFSObjectMetadata() {
		FSObjectMetadata parent = new FSObjectMetadata();
		FSObjectMetadata child = new FSObjectMetadata();
		
		parent.addChild(child);
		
		System.assertEquals(1, parent.children.size());
		
		FSObjectMetadata.FSPicklistFieldMetadata plFieldMeta = new FSObjectMetadata.FSPicklistFieldMetadata();
		
		plFieldMeta.setPath('path');		
		plFieldMeta.setDisplayName('testfield');		
		plFieldMeta.setFieldType('PICKLIST');		
		
		FSObjectMetadata.FSPicklistOption opt = new FSObjectMetadata.FSPicklistOption('val1', 'name1', false);
		
		plFieldMeta.addOption(opt);
		
		System.assertEquals(1, plFieldMeta.options.size());
		
		parent.addField(plFieldMeta);
		
		System.assertEquals(1, parent.fields.size());
		
		System.assertEquals('path', parent.fields.get(0).getPath());
		System.assertEquals('testfield', parent.fields.get(0).getDisplayName());
		System.assertEquals('PICKLIST', parent.fields.get(0).getFieldType());
	}    
}