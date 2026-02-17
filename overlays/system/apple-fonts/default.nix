{ stdenv, lib, fetchurl, p7zip, ... }:

# Installs SF and NY fonts

stdenv.mkDerivation rec {
  pname = "apple-fonts";
  version = "2026.02.10.1";

  appleFontSFPro = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-W0sZkipBtrduInk0oocbFAXX1qy0Z+yk2xUyFfDWx4s=";
  };

  appleFontSFCompact = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-RWeq4GFt01r8NLrWvvVH5y/R5lhFMFozlzBkUY0dU0g=";
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
