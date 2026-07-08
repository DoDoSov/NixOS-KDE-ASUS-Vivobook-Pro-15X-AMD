{config, pkgs, ...} : {
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 40;
		priority = 100;
	};
}
