{config, pkgs, inputs, lib, ...} : {
	environment.systemPackages = with pkgs; [
		#Base system-wise
		vim
		wget
		curl
		unzip
		zip
		p7zip
		tmux
		fastfetch
		btop
		git
		exfatprogs
		ntfs3g
		usbutils
		
		#VIA Keyboard configuration
		via
		qmk
		qmk-udev-rules
		qmk_hid
		vial

		#For DavinciBox
		lshw-gui
		appimage-run
	
		#Optional
		firefox
		cacert

		#Asus MUX Controller
		asusctl

		#FFMPEG
		(ffmpeg-full.override {withUnfree = true; config.rocmSupport = true; config.cudaSupport = true;})
	];
	
	#Thunderbolt/USB4
	services.hardware.bolt.enable = true;
	
	#XP-PEN Artist Pro 12 + Lenovo Thinkvision LT1423p Touch/Stylus
	programs.xppen = {
		enable = true;
		package = pkgs.xppen_4;
	};
	hardware.uinput.enable = true;

	#Bash-script support
	services.envfs.enable = true;

	#Garbage collector
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};
}
