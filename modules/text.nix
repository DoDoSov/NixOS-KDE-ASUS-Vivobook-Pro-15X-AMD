{config, lib, pkgs, ...} : {
	#Fonts Supports
	fonts = {
		packages = with pkgs; [
			nerd-fonts.iosevka
			noto-fonts-cjk-serif
			noto-fonts
			noto-fonts-color-emoji
			liberation_ttf
			fira-code
			fira-code-symbols
			jetbrains-mono
			
			#Korean/Chinise/Japanese Support
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			source-han-sans
			source-han-serif
			wqy_microhei
			wqy_zenhei
			maple-mono.truetype
			maple-mono.NF-unhinted
			maple-mono.NF-CN-unhinted
			lxgw-wenkai
		];
		
		fontconfig = {
			enable = true;
			defaultFonts = {
				serif = [ "Noto Serif CJK SC" "Noto Serif" ];
				sansSerif = [ "Noto Sans CJK SC" "Noto Sans" ];
				monospace = [ "JetBrains Mono" "Fira Code" ];
				emoji = [ "Noto Color Emoji" ];
			};
		};
	};

	#FCITX5 - i18n
	i18n.defaultLocale = "en_US.UTF-8";
	
	i18n.inputMethod = {
		type = "fcitx5";
		enable = true;
		fcitx5 = {
			waylandFrontend = true;
			addons = with pkgs; [
				fcitx5-mozc
				fcitx5-gtk
				qt6Packages.fcitx5-skk-qt
				qt6Packages.fcitx5-configtool
				fcitx5-hangul
				fcitx5-fluent
			];
		};
	};
	
	environment.sessionVariables = {
		GTK_IM_MODULE = "fcitx5";
		QT_IM_MODULE = "fcitx5";
		XMODIFIERS = "@im=fcitx";
		SDL_IM_MODULE = "fcitx";
		GLFW_IM_MODULE = "ibus";
		INPUT_METHOD = "fcitx";
		FCITX_USE_WAYLAND = "0";
	};
	
	#SVG-Support
	programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];	
}
