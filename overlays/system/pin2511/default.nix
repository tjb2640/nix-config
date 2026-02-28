let
  pin2511 = import (builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/nixos-25.11.tar.gz";
    sha256 = "sha256_hash";
  }) {};
in
{
  environment.systemPackages = [ pin2511.krita ];
}
