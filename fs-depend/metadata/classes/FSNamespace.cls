public class FSNamespace {
	public static final String NAMESPACE = 'FsDepend'; 
	
	public static String prependNamespace(String name) {
		return NAMESPACE + '__' + name;
	}   
}