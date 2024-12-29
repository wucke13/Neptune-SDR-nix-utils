{
  stdenv,
  fetchFromGitHub,
  dfu-util,
  ubootTools,
  pluto-linux,
  pluto-u-boot,
}:

stdenv.mkDerivation (finalAttrs: {
  name = "pluto-fw";
  version = "0.39";
  src = fetchFromGitHub {
    owner = "analogdevicesinc";
    repo = "plutosdr-fw";
    rev = "v" + finalAttrs.version;
    hash = "sha256-ZQsOz2yrxG5hhBB0XCDAeSo9WNJgl4yNE/dEX6JbjJY=";
    # TODO do we need this?
    # fetchSubmodules = true;
  };

  nativeBuildInputs = [
    ubootTools
    dfu-util
  ];

  postPatch = ''
    patchShebangs scripts
  '';

  # TODO what about dts/dtb?
  # TODO what about initramfs?
  # TODO what about fsbl?
  # TODO what about MSD firmware files?
  # TODO what about DFU update firmware files?
  # TODO what about bitstream and XSA files?
  buildPhase = ''
    runHook preBuild

    mkdir --parent build

    cp ${pluto-linux}/zImage build/
    cp -- ${pluto-u-boot}/u-boot u-boot.elf
    cp -- ${pluto-u-boot}/env_common.o build/

    chmod --recursive +w build

    CROSS_COMPILE=${stdenv.cc.targetPrefix} scripts/get_default_envs.sh > build/uboot-env.txt
    mkenvimage -s 0x20000 -o build/uboot-env.bin build/uboot-env.txt

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp --recursive -- build "$out/"

    runHook postInstall
  '';
})
