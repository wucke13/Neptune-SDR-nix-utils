{
  stdenvNoCC,
  zstd,
  board ? "P210",
}:

stdenvNoCC.mkDerivation {
  name = "neptunesdr-boot-partition-bin";
  nativeBuildInputs = [ zstd ];

  src = ../assets/NeptuneSDR-${board}-sdcard-boot-partition.tar.zst;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -- "$out"
    tar --extract --directory "$out" --file "$src"
    runHook postInstall
  '';
}
