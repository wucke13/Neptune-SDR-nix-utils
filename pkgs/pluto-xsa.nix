{
  stdenv,
  fetchFromGitHub,
  xilinx-unified-2023-2,
  flock,
  target ? "pluto",
}:

stdenv.mkDerivation (finalAttrs: {
  name = "pluto-xsa";
  version = "0.39";

  src = fetchFromGitHub {
    owner = "analogdevicesinc";
    repo = "hdl";
    rev = "065c8f186ef87ff049d279ed5859ee8d97d91808";
    hash = "sha256-D/HmVZZ2l/FeScbZO+kx8wstVIE47P3ZzTIsL8QWIvA=";
  };

  nativeBuildInputs = [
    flock # needed by the Makefile
    xilinx-unified-2023-2
  ];

  buildPhase = ''
    runHook preBuild

    make -C "projects/${target}"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -- "$out"
    cp -- "projects/${target}/${target}.sdk/system_top.xsa" "$out/"

    runHook postInstall
  '';
})
