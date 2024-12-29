{
  fetchFromGitHub,
  linuxManualConfig,
  linuxPackages_6_1,
}:

# Upstream builds the kernel like this:
#
# $(TOOLS_PATH) make -C linux ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) zynq_$(TARGET)_defconfig
# $(TOOLS_PATH) make -C linux -j $(NCORES) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) zImage UIMAGE_LOADADDR=0x8000

let
  src = fetchFromGitHub {
    owner = "analogdevicesinc";
    repo = "linux";
    rev = "f3da30df60047dc5a0b8fa8c640be774e0f784d9";
    hash = "sha256-1Eas9TEXu3lgmV1o6Z72FoOXP0OjiNo5mgQz1s6pCtU=";
  };
in
linuxPackages_6_1.kernel.override {
  autoModules = false;
  kernelPreferBuiltin = true;
  enableCommonConfig = false; # only use our extraStructuredConfig
  defconfig = "zynq_pluto_defconfig";
  argsOverride = {
    inherit src;
    version = "6.1.0";
    modDirVersion = "6.1.0";
  };
  kernelPatches = [
    {
      # Make the zynq arch also build the pluto dtb
      name = "add-pluto-dtb";
      patch = ../patches/linux-kernel-add-pluto-dtb.patch;
    }
  ];
}
