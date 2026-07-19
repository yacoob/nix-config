{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gdu
    just
    nerd-fonts.fira-code
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
