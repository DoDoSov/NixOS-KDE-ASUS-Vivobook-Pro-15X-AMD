{ config, pkgs, lib, ...} : 
let focaltech = pkgs.stdenv.mkDerivation {
	pname = "libfprint-focaltech-ft9366-shim";
	version = "0.1.0";

	src = pkgs.fetchFromGitHub {
		owner = "leopalladium";
		repo = "focaltech-ft9366-arch-shim";
		rev = "main";
		hash = "sha256-J/aqyUYV5OSKNP21IHoJhmHtJR7w0/cfwTg6n5emdjA=";
	};

	nativeBuildInputs = [ pkgs.patchelf pkgs.pkg-config pkgs.autoPatchelfHook ];
	buildInputs = [ pkgs.glib pkgs.gusb pkgs.stdenv.cc.cc.lib pkgs.nss pkgs.pixman pkgs.libgudev ];

	buildPhase = '' 
		gcc -shared -fPIC -Wl,--version-script=shim.map -o focaltech-shim.so shim.c $(pkg-config --cflags --libs glib-2.0) -ldl
	'';

	installPhase = ''
		install -Dm755 libfprint-2.so.2.0.0 $out/lib/libfprint-2.so.2.0.0
		install -Dm755 focaltech-shim.so $out/lib/focaltech-shim.so
		
		patchelf --add-needed focaltech-shim.so $out/lib/libfprint-2.so.2.0.0
		
		ln -s $out/lib/libfprint-2.so.2.0.0 $out/lib/libfprint-2.so.2
		ln -s $out/lib/libfprint-2.so.2.0.0 $out/lib/libfprint-2.so

		mkdir -p $out/lib/pkgconfig
		echo "prefix=$out"  > $out/lib/pkgconfig/libfprint-2.pc
		echo "libdir=$out/lib" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "includedir=$out/include" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "Name: libfprint-2" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "Description: Generic C API for fingerprint reader access" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "Version: 1.99.0" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "Requires: gio-unix-2.0, gobject-2.0" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "Libs: -L$out/lib -lfprint-2" >> $out/lib/pkgconfig/libfprint-2.pc
		echo "Cflags: -I$out/include/libfprint-2" >> $out/lib/pkgconfig/libfprint-2.pc

		cp -r ${pkgs.libfprint}/include	$out/
		cp -r ${pkgs.libfprint}/lib/girepository-1.0	$out/lib/

		install -Dm644 60-libfprint-2.rules $out/lib/udev/rules.d/60-libfprint-2.rules
	'';
};

in
	
{
	services.fprintd = {
		enable = true;
		package = pkgs.fprintd.override { libfprint = focaltech; };
	};

	services.udev.packages = [ focaltech ];
	
	#FIX for power-saving
	services.udev.extraRules = ''
		ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="2808", ATTR{idProduct}=="a658", ATTR{power/control}="on", ATTR{power/autosuspend}="-1"
	'';

	security.pam.services.sudo.fprintAuth = true;
	security.pam.services.login.fprintAuth = true;
	security.pam.services.sddm.fprintAuth = true;

	users.groups.plugdev = {};
}
