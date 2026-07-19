{ pkgs, ... }: {
  home.packages = with pkgs; [
    gdu
    just
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
