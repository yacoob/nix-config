# Fish plugins across standalone HM and NixOS

## Problem

One `home.nix`, deployed two ways:

- **Standalone** (Fedora/Kubuntu): nothing else provides fish plugins, so the HM
  config must carry them itself.
- **NixOS**: plugins should be installed system-wide (reaches all users + root,
  e.g. after `sudo -i` then running `fish` by hand), so the HM config must *not*
  also carry them — otherwise your own user sources the plugin twice.

Same file, opposite behavior.

## The mechanisms

- **HM, per-user** — `programs.fish.plugins`. Build-time: HM generates
  `~/.config/fish/conf.d/plugin-<name>.fish` that prepends the plugin's
  `functions`/`completions` and sources its `conf.d`. Takes `.src` (the source
  tree), not the built package. Independent of `XDG_DATA_DIRS`.

  ```nix
  programs.fish.plugins = [
    { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
  ];
  ```

- **NixOS, system-wide (all users + root)** — `environment.systemPackages`.
  Vendor route: the built package installs `share/fish/vendor_*.d`, and system
  `programs.fish.enable` links those into the system profile, where every user's
  fish scans them. Requires `programs.fish.enable = true`. NixOS has **no**
  `programs.fish.plugins`.

  ```nix
  programs.fish.enable = true;                                  # required
  environment.systemPackages = [ pkgs.fishPlugins.fzf-fish ];   # built pkg, not .src
  ```

Do not list a plugin in both a vendor route (`home.packages` /
`environment.systemPackages`) and `programs.fish.plugins` — that double-sources.

## Solution: gate the HM plugin on `osConfig`

HM exposes `osConfig`: `null` in standalone, the NixOS system config when run as
a NixOS module (added `mkDefault null` so it's safe to reference either way —
nixpkgs #311709; also see `nixosConfig`, the older NixOS-only alias). No
dedicated `isNixOS` helper exists; you write the guard yourself.

```nix
{ config, pkgs, lib, osConfig, ... }:

let
  onNixos = osConfig != null;
in {
  programs.fish = {
    enable = true;
    plugins = lib.optionals (!onNixos) [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
}
```

- Standalone → `onNixos = false` → HM installs the plugin.
- NixOS module → `onNixos = true` → HM adds nothing; the system config covers it.

When gating on system fish specifically, guard the null first:
`osConfig != null && (osConfig.programs.fish.enable or false)` — `x.y or false`
throws when `x` is `null`.

Applying this also means dropping the plugin from `home.packages`.
