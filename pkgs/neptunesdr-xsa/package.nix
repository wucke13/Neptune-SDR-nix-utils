{
  lib,
  pluto-xsa,
  enableCmos25 ? true,
  enableLvds25 ? false,
}:

# Exactly one of enableCmos25, enableLvds25 must be enabled
assert (enableCmos25 != enableLvds25) && (enableCmos25 || enableLvds25);

pluto-xsa.overrideAttrs (_: {
  prePatch = ''
    cp ${
      if enableCmos25 then ./cmos25-system_constr.xdc else ./lvds25-system_constr.xdc
    } projects/pluto/system_constr.xdc
  '';

  patches = [
    ./adihdl-pluto-to-neptunesdr-adaptation.patch
  ];

  # Config parameter: CMOS_OR_LVDS_N
  # Meaning: Defines the physical interface type, set 1 for CMOS and 0 for LVDS
  postPatch = lib.strings.optionalString enableLvds25 ''
    substituteInPlace projects/pluto/system_bd.tcl \
      --replace-fail 'CONFIG.CMOS_OR_LVDS_N 1' 'CONFIG.CMOS_OR_LVDS_N 0'
  '';
})
