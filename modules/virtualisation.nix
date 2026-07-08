{config, pkgs, ...} : {
	#Extra Packages
	environment.systemPackages = with pkgs; [
		dive
		docker-compose
		postman
		distrobox
		distroshelf

		#Waydroid
		waydroid-helper

		#WinBoat
		winboat
	];

	#VirtualBox
	virtualisation.virtualbox.host.enable = true;
	virtualisation.virtualbox.host.enableExtensionPack = true;
	virtualisation.virtualbox.guest.enable = true;
	virtualisation.virtualbox.guest.dragAndDrop = true;
	users.extraGroups.vboxusers.members = [ "dedos" ];
	
	#Docker
	virtualisation.containers.enable = true;
	virtualisation.docker = {
		enable = true;
		#enableNvidia = true;
		enableOnBoot = false;
	};

	#Waydroid
	virtualisation.waydroid.enable = true;
}
