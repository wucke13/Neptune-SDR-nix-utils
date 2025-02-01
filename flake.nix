{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.xilinx-nix-utils.url = "github:DLR-FT/xilinx-nix-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        # packages for the current host system
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.default
            (final: prev: {
              inherit (inputs.xilinx-nix-utils.packages.${system}) xilinx-unified-2023-2;
            })
          ];
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
