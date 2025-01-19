{
  stdenv,
  fetchFromGitHub,
  unzip,
  pluto-xsa,
  gcc-arm-embedded,
  board ? "pluto",
}:

stdenv.mkDerivation (finalAttrs: {
  name = "pluto-fsbl";
  version = "2024.2";
  src = fetchFromGitHub {
    owner = "Xilinx";
    repo = "embeddedsw";
    rev = "xilinx_v${finalAttrs.version}";
    hash = "sha256-j2wY1XQ4TFGZpDcORXDwDpXSUEnAnl8TcBeA2y9bln4=";
  };
  nativeBuildInputs = [
    gcc-arm-embedded
    unzip
  ];

  prePatch = ''
    patchShebangs .

    pushd lib/sw_apps/zynq_fsbl/misc/
    cp --recursive -- zed ${board}

    unzip -o ${pluto-xsa}/*.xsa -d ${board}

    popd
  '';
  preConfigure = ''
    cd lib/sw_apps/zynq_fsbl/src
  '';

  # See the following link for more information
  # https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/439124055/Zynq-7000+FSBL#Zynq-7000FSBL-WhatarevariouslevelsofcompilationflagsinFSBL?
  makeFlags = [
    "BOARD=${board}"
    # "CFLAGS=-DFSBL_DEBUG"
    "CFLAGS=-DFSBL_DEBUG_INFO"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -- "$out"
    cp -- fsbl.elf "$out/"

    runHook postInstall
  '';
})
