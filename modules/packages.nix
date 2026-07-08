{config, pkgs, lib, ...} : {
	#Unfree Packages
	nixpkgs.config.allowUnfree = true;

	#Nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	#Appimage support
	programs.appimage = {
		enable = true;
		binfmt = true;
	};

	#Flatpak support
	services.flatpak = {
		enable = true;
		
		#remotes = [{
		#	name = "flathub-beta";
		#	location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
		#}];

		#packages = [
		#	#Flatseal
		#	"com.github.tchx84.Flatseal"
		#	#GearLever
		#	"it.mijorus.gearlever"
		#];

		#Auto updates via nix-flatpak flake
		#update.auto = {
		#	enable = true;
		#	onCalendar = "weekly";
		#};
	};
}
