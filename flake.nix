{
  
  description = "tjb2640 NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # noctalia-shell for niri compositor
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Zen browser community flake
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  # Remember to include plasma-manager on Plasma systems:
  # home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs: {
    nixosConfigurations = {

      # Thinkpad X13 gen 3 (AMD)
      nix13 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/nix13/system.nix
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ty = import ./hosts/nix13/home/ty/home.nix;
          }
        ];
      };

      # Thinkpad P14s (nvidia, intel :( )
      # This looks a lot like nix13 (above) but with additional nvidia stuff
      nix14s = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/nix14s/system.nix
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ty = import ./hosts/nix14s/home/ty/home.nix;
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
          }
        ];
      };

    };
  };

}
