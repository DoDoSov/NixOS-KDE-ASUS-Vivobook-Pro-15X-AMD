{config, lib, pkgs, ...} : {
	#packages
	environment.systemPackages = with pkgs; [
		#Bases for windows run
		protonup-qt
		wine
		wine64
		gamescope
		gamemode
		#Prism Launcher - Minecraft
		(prismlauncher.override {
				additionalPrograms = [ ffmpeg ];
				jdks = [
					graalvmPackages.graalvm-ce
					zulu8
					zulu17
					zulu
				];
			}	
		)
		#Heroic
		heroic
		#Lossless Scaling Frame Gen
		lsfg-vk
		lsfg-vk-ui
		#Lutris
		(lutris.override{
			extraLibraries = pkgs: [];
			extraPkgs = pkgs: [];
		})

		#Emulators
		ppsspp-qt
		pcsx2
		#rpcs3
		shadps4
		xenia-canary
		xemu
		dolphin-emu
		cemu
		eden
	];

	#Steam
	programs.steam = {
		enable = true;
		#remotePlay.openFirewall = true;
		#extest.enable = true;
	};
	programs.gamemode.enable = true;
	programs.gamescope.enable = true;

	
}
