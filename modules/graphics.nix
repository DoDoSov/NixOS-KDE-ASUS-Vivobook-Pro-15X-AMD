{config, lib, pkgs, ...} : {
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
		
	hardware.amdgpu = {
		opencl.enable = true;
		initrd.enable = true;
	};
	nixpkgs.config.rocmSupport = true;

	services.xserver.videoDrivers = ["amdgpu" "nvidia"];
	
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = true;
		open = true;
		nvidiaSettings = true;
		prime = {
			offload.enable = true;
			offload.enableOffloadCmd = true;
			nvidiaBusId = "PCI:1:0:0";
			amdgpuBusId = "PCI:231:0:0";
		};
		package = config.boot.kernelPackages.nvidiaPackages.beta;
	};
}
