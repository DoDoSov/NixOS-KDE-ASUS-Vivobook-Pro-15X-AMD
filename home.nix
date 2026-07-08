{ config, lib, pkgs, inputs, ... } : {
	imports = [
		inputs.zen-browser.homeModules.beta		
	];
	
	home.enableNixpkgsReleaseCheck = false;
	home.username = "dedos";
	home.homeDirectory = "/home/dedos";
	home.stateVersion = "26.05";
	nixpkgs.config.allowUnfree = true;

	home.sessionVariables = {
		EDITOR = "antigravity";
		BROWSER = "zen-beta";
		TERMINAL = "konsole";
		XDG_CACHE_HOME = "/home/dedos/.cache";
	};
	
	home.packages = with pkgs; [
		#Everyday apps
		vesktop
		obsidian

		telegram-desktop
		viber
		caprine
		karere

		libreoffice

		antigravity

		godot
		godot-mono
		unityhub

		krita		
		kicad
		arduino-ide
		darktable
		inkscape-with-extensions
		freecad

		#blender CUDA+HIP+OPTIX
		(blender.override{
			config.rocmSupport = true;
			config.cudaSupport = true;
		})

		anydesk
		rustdesk

		hakuneko

		#For test purposes
		ungoogled-chromium
		
		#Utilities
		peazip
		kando
		motrix-next
		
		devenv

		firefoxpwa

		qalculate-qt
		rpi-imager

		#Flakes
		affinity-v3
		inputs.scopebuddy.packages.${pkgs.stdenv.hostPlatform.system}.default	
	];

	#Change name and email here to urs
	programs.git = {
		enable = true;
		settings = {
			user.name = "xxxx";
			user.email = "xxxxx@gmail.com"; 
		};
	};

	programs.obs-studio = {
		enable = true;

		#cuda support
		package = (
			pkgs.obs-studio.override {
				cudaSupport = true;
			}
		);
		
		plugins = with pkgs.obs-studio-plugins; [
			wlrobs
			obs-backgroundremoval
			obs-pipewire-audio-capture
			obs-vaapi
			obs-gstreamer
			obs-vkcapture
		];
	};
	programs.zen-browser = {
		enable = true;
		setAsDefaultBrowser = true;
		nativeMessagingHosts = [ pkgs.firefoxpwa ];
	};
}
