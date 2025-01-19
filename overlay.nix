final: prev:
let
  inherit (prev) lib;

  # root dir of this flake
  flakeRoot = ./.;

  # all packages from the local tree
  sdr-nix-utils =
    lib.filesystem.packagesFromDirectoryRecursive {
      # a special callPackage variant that contains our flakeRoot
      callPackage = lib.callPackageWith (final // { inherit flakeRoot; });

      # local tree of packages
      directory = ./pkgs;
    }
    // {
      # globally override pluto-xsa with bin version so we don't depend on xilinx tooling for pluto
      neptunesdr-xsa = final.neptunesdr-xsa-bin;
      pluto-xsa = final.pluto-xsa-bin;
      pluto-rootfs = final.pluto-rootfs-bin; # TODO make the non-bin version work at all

      # some packages require cross compiling
      pluto-u-boot = final.pkgsCross.armv7l-hf-multiplatform.callPackage ./pkgs/pluto-u-boot.nix { };
      pluto-linux = final.pkgsCross.armv7l-hf-multiplatform.callPackage ./pkgs/pluto-linux.nix { };

    };
in

{
  # https://github.com/NixOS/nixpkgs/pull/42637
  requireFile =
    args:
    (prev.requireFile args).overrideAttrs (_: {
      allowSubstitutes = true;
    });

  sdrangel =
    (prev.sdrangel.overrideAttrs (old: {
      hardeningDisable = [ "all" ]; # it crashes all the time
      # impureUseNativeOptimizations = true;
    })).override
      {
        stdenv = prev.stdenvAdapters.impureUseNativeOptimizations prev.stdenv; # squeeze out all performance
      };

  soapysdr-with-plugins = prev.soapysdr.override {
    extraPackages = with final; [
      limesuite
      soapyairspy
      soapyaudio
      soapybladerf
      soapyhackrf
      soapyplutosdr
      soapyremote
      soapyrtlsdr
      soapyuhd
    ];
  };

  # custom namespace for packages from the local tree
  inherit sdr-nix-utils;
}
// sdr-nix-utils
