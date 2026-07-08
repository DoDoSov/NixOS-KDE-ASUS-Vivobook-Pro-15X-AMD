{config,pkgs,...} : {
	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
	};
	services.desktopManager.plasma6.enable = true;

	environment.systemPackages = with pkgs; [
		kdePackages.kcalc
		kdePackages.kate
		kdePackages.kcharselect
		kdePackages.kclock
		kdePackages.kcolorchooser
		kdePackages.ksystemlog
		kdePackages.sddm-kcm
		kdePackages.isoimagewriter
		kdiff3
		kdePackages.partitionmanager
		kdePackages.plasma-thunderbolt
		
		hardinfo2
		wayland-utils
		wl-clipboard
		vlc
		mpv

		#Tiling
		kdePackages.krohnkite

		kdePackages.qtdeclarative
		kdePackages.qtsvg
		kdePackages.qt5compat
	];	
	environment.plasma6.excludePackages = with pkgs; [
		kdePackages.ksudoku
		kdePackages.ktorrent
		kdePackages.kpat
		kdePackages.konversation
		kdePackages.kpat
		kdePackages.kmines
		kdePackages.kmahjongg
		kdePackages.discover
		kdePackages.kolourpaint
	];

	#X11
	services.xserver.enable = true;
}
