final: prev: {
  iio-oscilloscope = prev.callPackage ./pkgs/iio-oscilloscope.nix { };
  soapyplutosdr = prev.callPackage ./pkgs/soapyplutosdr.nix { };
  urh = prev.callPackage ./pkgs/urh.nix { };

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
