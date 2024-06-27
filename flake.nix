{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ]
      (system:
        let
          # packages for the current host system
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };

          # packages for the SDR processor
          pkgsCross = import nixpkgs {
            inherit system;
            crossSystem = {
              config = "armv7l-unknown-linux-gnueabihf";
              isStatic = true;
            };
          };
        in
        {
          packages = { inherit (pkgs) iio-oscilloscope soapyplutosdr urh; };
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.gnuradio
              pkgs.libiio
              pkgs.iio-oscilloscope
              # pkgs.sdrangel
              pkgs.sigdigger
              pkgs.soapysdr
              pkgs.urh
              pkgs.gqrx
            ];
          };
        }
      ) // {
      overlays.default = import ./overlay.nix;
    };
}
