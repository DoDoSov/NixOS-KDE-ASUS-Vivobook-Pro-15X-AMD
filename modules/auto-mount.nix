{config, pkgs, lib, ...} : {
	#USB Automount
	#services.gvfs.enable = true;
	#services.devmon.enable = true;
	#services.udisks2.enable = true;

	fileSystems."/mnt/ssd" = {
		device = "/dev/disk/by-partuuid/24dd2a95-36f3-4cdc-9e30-ce5a1dcdf78d";
		fsType = "xfs";
		options = ["nofail" "x-gvfs-show"];
	};
}
