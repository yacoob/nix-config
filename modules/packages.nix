{
  lib,
  pkgs,
  flavourAtLeast,
  ...
}:
lib.mkIf (flavourAtLeast "base") {
  home.packages = with pkgs; [
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
