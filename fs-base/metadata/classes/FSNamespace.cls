public class FSNamespace {
	public static final String NAMESPACE = 'fsbase'; 
	
	public static String prependNamespace(String name) {
		return NAMESPACE + '__' + name;
	}   
}