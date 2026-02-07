# Organization/philosophy

This is not a dendritic config and likely never will be. I use `flake.nix` as the entrypoint to my per-host configurations. Each host is defined in `/hosts` and imports common values from `/config`. This setup assumes a single user, `ty`, but I have still taken the initiative to split out importable config files per-user for futureproofing.

## System config
The "system" side of the config is imported in each host's `system.nix` file, e.g. `/hosts/nix13/system.nix` for host `nix13`. Importable system configuration files live in `/config/system/`.

Each host needs to import one (and only one) of the following files from `/config/system/base`, depending on the type of computer: `desktop.nix`, `laptop.nix`, or `server.nix`.

Extra packages that might only be wanted on specific hosts can be imported from `/config/system/packages`:

- All desktop or laptop computers with an Nvidia GPU should import `nvidia.nix` from here, and then set some machine-specific Bus ID values in their own host `configuration.nix` file. Host `nix14s` provides an example of what to do here.
- For reasons, I have replaced Firefox in daily usage with Zen Browser, which is configured in home manager and not at the system level. During the course of migration, I am keeping `firefox.nix` around so I can flip back into Firefox for whatever.
- `gaming.nix` enables Steam and some extra packages like Proton.

Inside `/config/system/packages/desktop` live configs for the Plasma desktop and the niri compositor. I use niri now and am keeping Plasma around just in case I need the config again.

## home-manager config

I use `home-manager` to configure my home directory. All hosts should have a `/hosts/HOSTNAME/home/ty/home.nix` file for this.

Importable home manager config files live in `/config/home/users/ty`. From that directory, `home.nix` should explicitly import either `base/base.nix` (on servers, for instance) or `base/desktop.nix`. These files should define all home-manager configuration options for the appropriate machine-type context, besides desktop environments, compositors, or optional packages..

If in the system config a `desktop/` file was imported, the file with the same name should be imported from `/config/home/users/ty/packages/desktop`. Optional packages should just go in `packages/**.nix`.

## Overlays

Locally-defined overlays should be placed in `/overlays/system/OVERLAY-NAME/default.nix`.

## Resource files

Place all image and document resource files in `/resource`.
