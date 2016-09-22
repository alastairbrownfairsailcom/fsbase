global class PostInstall implements InstallHandler {
	global void onInstall(InstallContext context) {
        fsbase.FSProcessRegister.register('Shout Out Process', 'FsDepend', 'ShoutOutProcess', 'ShoutOutDeserializer', 'ShoutOutSerializer', 'shoutout-process', new List<String> {'ShoutOut'}, true);
    	fsbase.FSProcessRegister.saveRegistered();  	
	}
}