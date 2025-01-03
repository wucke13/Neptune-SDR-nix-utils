{
  stdenvNoCC,
  fetchurl,
  unzip,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  name = "pluto-xsa-bin";
  version = "0.39";

  src = fetchurl {
    url = "https://github.com/analogdevicesinc/plutosdr-fw/releases/download/v${finalAttrs.version}/system_top.xsa";
    hash = "sha256-MMLnIyyIHgDI1l6t/QWK8qslVteb1qAtrgBay6xyY8w=";
  };
  dontUnpack = true;
  installPhase = ''
    runHook preInstall

    mkdir -- "$out"
    cp -- "$src" "$out/system_top.xsa"

    runHook postInstall
  '';
})
