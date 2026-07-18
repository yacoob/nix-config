{ pkgs, ... }: {
  home.packages = with pkgs; [
    gdu
    jujutsu
    just
    lazygit
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
