# Organization/philosophy

This is not a dendritic config and likely never will be. I use `flake.nix` as the entrypoint to my per-host configurations. Each host is defined in `/hosts` and imports common values from `/config`. This setup assumes a single user, `ty`.

## System config
The "system" side of the config is imported in each host's `system.nix` file, e.g. `/hosts/nix13/system.nix` for host `nix13`. Importable system configuration files live in `/config/system/`.

Each host needs to import one (and only one) of the following files from `/config/system/base`, depending on the type of computer: `desktop.nix`, `laptop.nix`, or `server.nix`.

Extra packages that might only be wanted on specific hosts can be imported from `/config/system/extras`. All desktop or laptop computers with an Nvidia GPU should import `nvidia.nix` from here, and then set some machine-specific Bus ID values in their own host `configuration.nix` file. Host `nix14s` provides an example of what to do here.

## home-manager config

I use `home-manager` to configure my home directory. All hosts should have a `/hosts/HOSTNAME/home/home.nix` file for this.

Importable home manager config files live in `/config/home`. From that directory, `home.nix` should explicitly import either `base/base.nix` (on servers, for instance) or `base/desktop.nix`. These files should define all home-manager configuration options for the appropriate machine-type context, besides desktop environments, compositors, or optional packages..

Files in `/config/home` matching the names of files in `/config/system` should be imported when they are referenced in `/config/system`.

## Overlays

Locally-defined overlays should be placed in `/overlays/system/OVERLAY-NAME/default.nix`.

## Resource files

Place all image and document resource files in `/resource`.
