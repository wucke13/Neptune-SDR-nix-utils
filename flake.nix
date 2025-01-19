{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        # packages for the current host system
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };

        # packages for the SDR processor
        pkgsCross = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
          crossSystem = {
            config = "armv7l-unknown-linux-gnueabihf";
          };
        };
      in
      {
        packages = pkgs.sdr-nix-utils;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            (pkgs.soapysdr.override { extraPackages = [ self.packages.${system}.soapyplutosdr ]; })
            pkgs.gnuradio
            pkgs.gqrx
            pkgs.iio-oscilloscope
            pkgs.libiio
            # pkgs.sdrangel
            pkgs.sigdigger
            pkgs.urh
          ];
        };
      }
    )
    // {
      overlays.default = import ./overlay.nix;
    };
}
