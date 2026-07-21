# nix-config

Standalone home-manager flake (`homeConfigurations."yacoob"`, x86_64-linux),
gradually replacing the older chezmoi dotfiles. See README "Next" for roadmap.

## Testing changes

- **Never activate on this workstation.** Changes are tested in a VM first. Do not run `home-manager switch` / activation here — this is the live desktop. The VM has the same repo mounted under ~/workarea/nix-config
- Host-side work is safe: editing, `nix build`, `nix store diff-closures`, and inspecting generated activation payloads (e.g. plasma-manager's `data.json`).
- To preview a change's real effect, diff against a fresh baseline build of the
  committed HEAD — not the installed profile:

  ```
  nix build "git+file://$PWD?rev=$(jj log --no-graph -r @- -T commit_id)#homeConfigurations.yacoob.activationPackage" -o base
  nix build .#homeConfigurations.yacoob.activationPackage -o new
  nix store diff-closures ./base ./new
  ```

## Flake eval gotchas

- `path:` flakerefs fail here — `.git/fsmonitor--daemon.ipc` is a git fsmonitor
  socket that Nix can't copy. Use `.` / `git+file:` (git source excludes `.git`).
- `nixpkgs.config.allowUnfree = true` in `home.nix` **does** take effect, even
  though `flake.nix` passes an external `pkgs` (`nixpkgs.legacyPackages`). HM
  re-instantiates nixpkgs with `nixpkgs.config` applied — the config's own
  `pkgs` has `allowUnfree = true` while raw `legacyPackages` has it `false`.
  Verify with:
  `nix eval --impure --expr '(builtins.getFlake "git+file://$PWD").homeConfigurations.base.pkgs.config.allowUnfree'`

## Layout

`flake.nix` holds inputs and pulls in external flake modules (lazyvim,
plasma-manager). `home.nix` imports `modules/`, one file per concern; personal
settings live in `modules/`.
