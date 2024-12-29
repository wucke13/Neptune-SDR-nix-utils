final: prev: {
  iio-oscilloscope = prev.callPackage ./pkgs/iio-oscilloscope.nix { };
  soapyplutosdr = prev.callPackage ./pkgs/soapyplutosdr.nix { };
  urh = prev.callPackage ./pkgs/urh.nix { };

  pluto-image = prev.callPackage ./pkgs/pluto-image.nix { };
  pluto-linux = prev.callPackage ./pkgs/pluto-linux.nix { };
  pluto-u-boot = prev.callPackage ./pkgs/pluto-u-boot.nix { };

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
}
