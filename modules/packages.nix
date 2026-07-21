{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf (config.flavour.atLeast "base") {
  home.packages = with pkgs; [
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
