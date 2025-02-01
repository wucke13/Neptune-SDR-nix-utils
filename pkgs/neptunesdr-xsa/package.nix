{
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

    substituteInPlace projects/pluto/system_project.tcl \
      --replace-fail 'xc7z010clg225-1' 'xc7z020clg400-1'
  '';
})
