{config, pkgs, ...} : {
	#Internet
	networking.networkmanager.enable = true;
	
	#Bluetooth
	#services.blueman.enable = true;
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General = {
				Experimental = true;
				FastConnectable = true;
				
				#A2DP
				Enable = "Source,Sink,Media,Socket";
			};
			Policy = {
				AutoEnable = true;
			};
		};
	};

	#Audio	
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
	};	

	#Printing
	services.printing.enable = true;

	#AsusD
	services.asusd = {
		enable = true;
		#enableUserService = true;
	};
	
}
