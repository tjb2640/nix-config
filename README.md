# My NixOS Configuration

![Alt text](resource/images/nixos_256.png)

This is my personal [NixOS](https://nixos.org/) configuration.

NixOS is a declarative operating system wrapped around the Nix package manager.
Instead of imperatively installing supplemental programs and packages with a pacakge manager like `apt` or `pacman`,
everything is managed from within this set of config files and the system is rebuilt when new things are added.

Interesting stuff is in `config/` and my `hosts/nix13` host.
A configuration for Nvidia cards is in `config/programs/nvidia.nix`
and the host-specific config for `hosts/nix14s/configuration.nix`.

## Cool reference

I have been enjoying [this](https://nixos-and-flakes.thiscute.world/preface) 
book from https://github.com/ryan4yin and have been recommending it to folks 
looking to learn NixOS. Go check it out and give it a star!

## My split config structure

I've attempted to separate out my config files and organize them based on their scope,
first by each host in `hosts/`, then between system- and home-level configs in `config/`.

Overlays local to this configuration are stored in the `overlays/` directory and then split out in the same way.
Right now I only have `overlays/system/` overlays.

- **`hosts/`**: flaked out, specific to each machine.
  - `configuration.nix`: sets hostname and imports from `config/system/` as needed
  - `hardware-configuration.nix`
  - `home.nix`: machine-specific values for `home-manager` and `plasma-manager`; also imports from `config/home/` as needed
- `config/`: branched-off files included by files in `hosts/`
  - **`home/`**: having to do with home directories and user-specific things. 
  Imported from `hosts/<HOSTNAME>/home.nix`
    - `<USERNAME>/base.nix`: home-manager values for all machines
    - `<USERNAME>/desktop.nix`: " for desktop/graphical machines
    - `<USERNAME>/plasma-manager.nix`: for `plasma-manager`.
    Panel setup, common input device settings, theming, all that
  - **`system/`**: having to do with base host configs. 
  Imported from `hosts/<HOSTNAME>/configuration.nix`
    - `base/`: contains commonly-used values across multiple hosts
      - `base.nix`: base values for all types of machines, not to be imported directly
      - `desktop.nix`: for all desktop (non-portable graphical) machines
      - `laptop.nix`: for all laptops/portables (inherits `desktop`)
      - `server.nix`: values for server machines; mostly firewall and SSH right now
    - `de/`: configs which enable and configure desktop environments.
    Right now I only maintain/use `plasma.nix` for Plasma 6 but some `gnome.nix` stuff is in here as well
    - `extras/`: additional system packages and services
      - `bluetooth.nix`: enables Bluetooth and Blueman
      - `firefox.nix`: enables Firefox and sets some managed options (does not touch `user.js`)
      - `gaming.nix`: Steam and some emulators
      - `nvidia.nix`: excluding machine-specific things, enables Nvidia, modesetting, and power management. 
      Example machine-specific values like prime bus IDs can be found in `/hosts/nix14s/configuration.nix`
      - `plymouth.nix`: enables plymouth to customize my boot process and enables my custom theme overlay
      - `slop.nix`: AI (ollama & open-webui), in case I ever need to enable it for something; unlikely
- `overlays/system/`: system-level overlay files
  - `apple-fonts`: downloads, extracts, & installs Apple's San Francisco and New York fonts
  - `plasma-theme-claremont`: installs my custom aurorae (window decor), colour scheme, and panel theme for Plasma 6
  - `plymouth-theme-rbsys`: installs my custom plymouth theme
- `resource/`: commonly-referenced static files, images, etc.