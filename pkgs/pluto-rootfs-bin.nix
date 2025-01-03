{
  stdenvNoCC,
  fetchurl,
  libarchive,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  name = "pluto-rootfs-bin";
  version = "0.39";

  src = fetchurl {
    url = "https://github.com/analogdevicesinc/plutosdr-fw/releases/download/v${finalAttrs.version}/sysroot-v${finalAttrs.version}.tar.gz";
    hash = "sha256-oJlY3RUVtAKq8v26PeGAE+usoJXm1K+RZOes0jXcREs=";
  };
  dontUnpack = true;
  sourceRoot = ".";
  nativeBuildInputs = [ libarchive ];

  # TODO check if permissions/ownership/setuid stuff is a problem
  installPhase = ''
    runHook preInstall

    mkdir -- "$out"
    target="$out/$(stripHash "$src")"
    target="''${target%%.tar.gz}.cpio.gz"

    # --strip-components get's rid of the top level staging directory in the tar.gz
    bsdtar --format=cpio --same-owner --same-permissions --create --strip-components 1 --file - "@$src" | gzip -q -9 -c > "$target"

    runHook postInstall
  '';
})
