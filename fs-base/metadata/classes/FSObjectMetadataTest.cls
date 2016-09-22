@isTest
public class FSObjectMetadataTest {
	public static testmethod void testFSObjectMetadata() {
		FSObjectMetadata parent = new FSObjectMetadata();
		FSObjectMetadata child = new FSObjectMetadata();
		
		parent.addChild(child);
		
		System.assertEquals(1, parent.children.size());
		
		FSObjectMetadata.FSPicklistFieldMetadata plFieldMeta = new FSObjectMetadata.FSPicklistFieldMetadata();		
		
		FSObjectMetadata.FSPicklistOption opt = new FSObjectMetadata.FSPicklistOption('val1', 'name1', false);
		
		plFieldMeta.addOption(opt);
		
		System.assertEquals(1, plFieldMeta.options.size());
		
		parent.addField(plFieldMeta);
		
		System.assertEquals(1, parent.fields.size());
	}
    
}