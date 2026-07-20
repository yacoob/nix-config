{ lib, pkgs, ... }:
lib.mkIf (lib.flavourAtLeast "base") {
  home.packages = with pkgs; [
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
