public class ShoutOut implements FSObjectDTO {
	@AuraEnabled
    public String name {get; private set;}
    
    public ShoutOut(String name) {
    	this.name = name;
    }
}