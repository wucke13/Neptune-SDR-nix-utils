{ pluto-u-boot }:

pluto-u-boot.overrideAttrs (_: {
  patches = [ ./u-boot-pluto-to-neptunesdr-p210.patch ];
})
