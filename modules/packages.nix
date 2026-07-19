{ pkgs, ... }: {
  home.packages = with pkgs; [
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
