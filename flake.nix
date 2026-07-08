{
	description = "Flake conf KDE - Asus Vivobook Pro 15x RM6505";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-for-26.05";
		
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake/beta";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.home-manager.follows = "home-manager";
		};

		scopebuddy.url = "github:HikariKnight/ScopeBuddy";
		
		winapps = {
			url = "github:winapps-org/winapps";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		affinity-nix.url = "github:mrshmllow/affinity-nix";

		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

		nix-snapd = {
			url = "github:nix-community/nix-snapd";
			inputs.nixpkgs.follows = "nixpkgs"; 
		};
	};
	
	outputs = { self, nixpkgs, home-manager, xlibre-overlay, zen-browser, scopebuddy, winapps, affinity-nix, nix-flatpak, nix-snapd,  ... }
	@inputs : {
		nixosConfigurations.dedos-hibiscus = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			
			specialArgs = {
				inherit inputs system;
			};
			
			modules = [
				./configuration.nix
				{
					nixpkgs.overlays = [ affinity-nix.overlays.default ];
				}

				nix-flatpak.nixosModules.nix-flatpak
				
				nix-snapd.nixosModules.default {
					services.snap.enable = true;
				}
				
				home-manager.nixosModules.default {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = { inherit inputs; };
						users.dedos = ./home.nix;
					};
				}
				inputs.xlibre-overlay.nixosModules.overlay-xlibre-xserver
				inputs.xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
			];
		};
	};
}
