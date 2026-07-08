{config, libs, pkgs, ...} : {
	environment.systemPackages = with pkgs; [
		displaylink
	];
	services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
	
	#Wayland Support
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.evdi ];
		initrd = {
			kernelModules = [
				"evdi"
			];
		};
	};
	
	#KDE Special
	environment.variables = {
		KWIN_DRM_PREFER_COLOR_DEPTH = "24";
	};

	systemd.services.displaylink-server = {
		enable = true;
		requires = [ "systemd-udevd.service" ];
		after = [ "systemd-udevd.service" ];
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.displaylink}/bin/DisplayLinkManager";
			User = "root";
			Group = "root";
			Restart = "on-failure";
			RestartSec = 5;
		};

	};
}
