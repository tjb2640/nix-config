{ lib, stdenv, fetchurl, unzip, ... }:

# Grab my own red plasma theme from my github (releases) & install it

stdenv.mkDerivation rec {
  pname = "plasma-theme-claremont";
  version = "2025.12.5.1";

  claremontTheme = fetchurl {
    url = "https://github.com/tjb2640/plasma6-claremont-theme/archive/refs/tags/v1.0.0.zip";
    sha256 = "sha256-CrdaUolotxnt+ndV3IRqq0eOS19UlrKAmyqOJRHhQNk=";
  };

  nativeBuildInputs = [ unzip ];
  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    mkdir -p $out/colourfiles
    mkdir -p $out/themefiles
    unzip ${claremontTheme}
    mv plasma6-claremont-theme-1.0.0/* $out/themefiles/
    cp $out/themefiles/colors $out/colourfiles/ClaremontDark.colors
  '';

  installPhase = ''
    mkdir -p $out/share/plasma/desktoptheme/ClaremontDark
    mkdir -p $out/share/color-schemes
    mv $out/themefiles/* $out/share/plasma/desktoptheme/ClaremontDark/
    mv $out/colourfiles/* $out/share/color-schemes/
  '';

  meta = {
    description = "Claremont - My Plasma 6 Theme";
    homepage = "https://github.com/tjb2640/plasma6-claremont-theme/";
    license = lib.licenses.lgpl3Plus;
  };

}
