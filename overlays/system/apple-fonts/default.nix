{ config, pkgs, lib, stdenv, fetchurl, p7zip, ... }:

# Installs SF and NY fonts

stdenv.mkDerivation rec {
  pname = "apple-fonts";
  version = "2025.11.21.0";

  appleFontSFPro = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-u7cLbIRELSNFUa2OW/ZAgIu6vbmK/8kXXqU97xphA+0=";
  };

  appleFontSFCompact = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-mcMM/cbmOA5ykyIb74bid9vU6wyl8nVwkvkd+VlOdwo=";
  };

  appleFontSFMono = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
  };

  appleFontNY = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-HC7ttFJswPMm+Lfql49aQzdWR2osjFYHJTdgjtuI+PQ=";
  };
  

  nativeBuildInputs = [ p7zip ];
  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    mkdir -p $out/fontfiles

    # function which does the .otf/.ttf extraction
    extract_font_files () {
      fetchedName=$1
      extractedDir=$2
      pkgName=$3

      7z x $fetchedName
      cd $extractedDir
      7z x "$pkgName"
      7z x 'Payload~'
      mv Library/Fonts/* $out/fontfiles
    }

    extract_font_files ${appleFontSFPro} SFProFonts 'SF Pro Fonts.pkg'
    extract_font_files ${appleFontSFCompact} SFCompactFonts 'SF Compact Fonts.pkg'
    extract_font_files ${appleFontSFMono} SFMonoFonts 'SF Mono Fonts.pkg'
    extract_font_files ${appleFontNY} NYFonts 'NY Fonts.pkg'
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype $out/share/fonts/truetype
    install -Dm644 $out/fontfiles/*.otf $out/share/fonts/opentype
    install -Dm644 $out/fontfiles/*.ttf $out/share/fonts/truetype
  '';

  meta = {
    description = "Apple fonts - San Francisco, NY";
    homepage = "https://developer.apple.com/fonts/";
    license = lib.licenses.unfree;
  };

}
