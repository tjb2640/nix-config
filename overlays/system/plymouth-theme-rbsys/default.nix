{ lib, stdenv, fetchurl, unzip, ... }:

# Theme plymouth with an "rbsys" logo featuring my window decorations

stdenv.mkDerivation rec {
  pname = "plymouth-theme-rbsys";
  version = "2025.12.25.1";

  rbsysTheme = fetchurl {
    url = "https://github.com/tjb2640/plymouth-theme-rbsys/archive/refs/tags/v1.0.0.zip";
    sha256 = "sha256-bw22+PhWYyC0xHsYU5+7gN9cqeQae+7qO/ADAFyYPzU=";
  };

  nativeBuildInputs = [ unzip ];
  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    unzip ${rbsysTheme}
    mkdir -p $out/plymouthfiles
    mv plymouth-theme-rbsys-1.0.0/* $out/plymouthfiles/
  '';

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/rbsys
    install -m 755 -vDt "$out/share/plymouth/themes/rbsys" "$out/plymouthfiles/rbsys."{plymouth,script}
    install -m 644 -vDt "$out/share/plymouth/themes/rbsys" "$out/plymouthfiles/"*png
    sed -i "s@\/usr\/@$out\/@" "$out/share/plymouth/themes/rbsys/rbsys.plymouth"
  '';

  meta = {
    description = "rbsys Plymouth Theme";
    homepage = "https://github.com/tjb2640/plymouth-theme-rbsys/";
    license = lib.licenses.mit;
  };

}
