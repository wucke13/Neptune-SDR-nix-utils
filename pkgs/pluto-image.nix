{
  lib,
  stdenv,
  fetchFromGitHub,

  dfu-util,
  dtc,
  ubootTools,
  unzip,
  xilinx-bootgen,

  pluto-linux,
  pluto-rootfs,
  pluto-u-boot,
  pluto-xsa,

  deviceVid ? "0x0456",
  devicePid ? "0xb673",
  target ? "pluto",
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
    dfu-util
    dtc
    ubootTools
    unzip
    xilinx-bootgen
  ];

  postPatch = ''
    patchShebangs scripts
  '';

  # TODO what about fsbl?
  buildPhase = ''
    runHook preBuild

    mkdir --parent build

    cp ${pluto-linux}/zImage build/
    cp -- ${pluto-u-boot}/u-boot build/u-boot.elf
    cp -- ${pluto-u-boot}/env_common.o build/

    chmod --recursive +w build

    CROSS_COMPILE=${stdenv.cc.targetPrefix} scripts/get_default_envs.sh > build/uboot-env.txt
    mkenvimage -s 0x20000 -o build/uboot-env.bin build/uboot-env.txt

    # build dtb
    for dtb in ${pluto-linux}/dtbs/*pluto*.dtb
    do
      output_dtb="build/''${dtb##*/}"
      dtc -q -@ -I dtb -O dts "$dtb" | sed 's/axi {/amba {/g' | dtc -q -@ -I dts -O dtb -o "$output_dtb"
      dtc -q -@ -I dtb -O dts "$output_dtb" --out "''${output_dtb%.dtb}.dts"
    done

    # build/copy initramfs
    cp -- ${pluto-rootfs}/*cpio.gz build/rootfs.cpio.gz

    # build/copy build/system_top.bit
    unzip ${pluto-xsa}/system_top.xsa \
      system_top.bit ps7_init.tcl \
      -d build

    # build pluto.itb
    mkimage -f scripts/${target}.its build/${target}.itb

    # build fsbl.elf
    cp build/u-boot.elf build/fsbl.elf # TODO remove this hack

    # build boot.bin
    echo "img:{[bootloader] build/fsbl.elf build/u-boot.elf }" > build/boot.bif
    bootgen -image build/boot.bif -w -o build/boot.bin

    # build the frm
    ## build pluto.frm
    md5sum build/${target}.itb | cut -d ' ' -f 1 > build/${target}.frm.md5
    cat build/${target}.itb build/${target}.frm.md5 > build/${target}.frm
    ## build boot.frm
    cat build/boot.bin build/uboot-env.bin scripts/target_mtd_info.key \
      | tee build/boot.frm | md5sum | cut -d ' ' -f1 | tee -a build/boot.frm

    # build the dfu
    for update in build/boot.bin build/${target}.itb
    do
      cp -- "$update" "$update.tmp"
      dfu-suffix -a "$update.tmp" -v ${deviceVid} -p ${devicePid}
      mv "$update.tmp" "''${update%.*}.dfu"
    done

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp --recursive -- build "$out/"

    runHook postInstall
  '';
})
