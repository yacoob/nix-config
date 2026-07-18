# nix-config task runner. Diff recipes run on the host (read-only, safe);
# `switch` is VM-only. See CLAUDE.md.
#
# Diff recipes take a baseline:
#   parent (default) — this revision vs its parent (@ vs @-): "what is this revision bringing?"
#   active           — working tree vs the in-use generation:  "what if I switch to this?"
set shell := ["bash", "-c"]

inst := "homeConfigurations.yacoob.activationPackage"

# list recipes
default:
    @just --choose

# build of the current working tree
_new:
    @nix build ".#{{inst}}" --no-link --print-out-paths

# build of the parent revision (jj @-)
_parent:
    @nix build "git+file://$PWD?rev=$(jj log --ignore-working-copy --no-graph -r @- -T commit_id)#{{inst}}" --no-link --print-out-paths

# the generation currently in use on this machine
_active:
    @readlink -f ~/.local/state/nix/profiles/home-manager

# high-level package/closure diff — what nix is doing (nvd). base: parent (default) | active
packages base="parent":
    nix run nixpkgs#nvd -- diff $(just _{{base}}) $(just _new)

# filesystem diff — the effect of switching (dereferenced content; no cp, no store-path churn). base: parent (default) | active
fs base="parent":
    @a=$(readlink -f "$(just _{{base}})"/home-files); b=$(readlink -f "$(just _new)"/home-files); diff -r "$a" "$b" | sed -e "s#$a#a#g" -e "s#$b#b#g"

# TUI browse of the merged config (git source dodges the fsmonitor socket)
inspect:
    nix run nixpkgs#nix-inspect -- -e "(builtins.getFlake \"git+file://$PWD\").homeConfigurations.yacoob.config"

# repl with the flake loaded (try: options.programs.fish.plugins.files)
repl:
    nix repl --impure --expr "builtins.getFlake \"git+file://$PWD\""

# VM ONLY: activate the config and drop into a fresh fish. Never on the workstation.
switch:
    home-manager switch --flake .#yacoob && exec fish
