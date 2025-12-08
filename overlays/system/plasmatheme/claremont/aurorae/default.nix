{ config, pkgs, lib, stdenv, fetchurl, unzip, ... }:

# Grab my own red plasma theme from my github (releases) & install it

stdenv.mkDerivation rec {
  pname = "aurorae-theme-claremont";
  version = "2025.12.7.0";

  claremontAurorae = fetchurl {
    url = "https://github.com/tjb2640/plasma6-claremont-aurorae/archive/refs/tags/v1.0.0.zip";
    sha256 = "sha256-guPTtxcP3ITWwWa/tLhjjMZLNfmknQ6T/iwuR6VXc10=";
  };

  nativeBuildInputs = [ unzip ];
  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    mkdir -p $out/colourfiles
    mkdir -p $out/themefiles
    unzip ${claremontAurorae}
    mv plasma6-claremont-aurorae-1.0.0/* $out/themefiles/
  '';

  installPhase = ''
    mkdir -p $out/share/aurorae/themes/ClaremontDark
    mv $out/themefiles/* $out/share/aurorae/themes/ClaremontDark/
  '';

  meta = {
    description = "Claremont - Aurorae (window decor)";
    homepage = "https://github.com/tjb2640/plasma6-claremont-aurorae";
    license = lib.licenses.mit;
  };

}
