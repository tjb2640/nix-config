# My NixOS Configuration

![Alt text](resource/images/nixos_256.png)

This is my personal [NixOS](https://nixos.org/) configuration.

NixOS is a declarative operating system wrapped around the Nix package manager.
Instead of imperatively installing supplemental programs and packages with a pacakge manager like `apt` or `pacman`,
everything is managed from within this set of config files and the system is rebuilt when new things are added.

Interesting stuff is in `config/` and my `hosts/nix13` host.
A configuration for Nvidia cards is in `config/programs/nvidia.nix`
and the host-specific config for `hosts/nix14s/configuration.nix`.

## TODO list
- Whittle down or add new configuration options
- ??? TBA

## Cool reference

I have been enjoying [this](https://nixos-and-flakes.thiscute.world/preface) 
book from https://github.com/ryan4yin and have been recommending it to folks 
looking to learn NixOS. Go check it out and give it a star!
