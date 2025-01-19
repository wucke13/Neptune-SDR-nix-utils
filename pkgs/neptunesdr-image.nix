{
  neptunesdr-fsbl,
  neptunesdr-u-boot,
  neptunesdr-xsa,
  pluto-image,
  pluto-rootfs,
}:

pluto-image.override {
  pluto-fsbl = neptunesdr-fsbl;
  pluto-rootfs = pluto-rootfs; # TODO customize
  pluto-xsa = neptunesdr-xsa;
  pluto-u-boot = neptunesdr-u-boot;
}
