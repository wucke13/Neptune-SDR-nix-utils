{
  stdenv,
  buildUBoot,
  fetchFromGitHub,
  bc,
  openssl,
}:

# Upstream builds U-Boot like this:
#
#	$(TOOLS_PATH) make -C u-boot-xlnx ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) zynq_$(TARGET)_defconfig
# $(TOOLS_PATH) make -C u-boot-xlnx ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) UBOOTVERSION="$(UBOOT_VERSION)"

buildUBoot {
  version = "unknown";

  src = fetchFromGitHub {
    owner = "analogdevicesinc";
    repo = "u-boot-xlnx";
    rev = "90401ce9ce029e5563f4dface63914d42badf5bc";
    hash = "sha256-gCXlHSNAsC6oDZThUX1W6WQiNcCPNkb4EadFvyb6UcY=";
  };

  filesToInstall = [
    "spl/boot.bin"
    "u-boot" # later becomes u-boot.elf
    "common/env_common.o" # we will extract the default env from here
  ];

  defconfig = "zynq_pluto_defconfig";

  patches = [ ]; # avoid nixos-special raspberry-pi patches from being applied

  nativeBuildInputs = [
    stdenv.cc.cc # so string.h is found by the host-cc
    bc
    openssl # FIT-image signatures require this on the build system!
  ];

  extraMeta.platforms = [ "armv7l-linux" ];
}
