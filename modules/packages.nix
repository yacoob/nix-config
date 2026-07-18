{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gdu
    jujutsu
    just
    lazygit
    nerd-fonts.fira-code
    nh
    nix-inspect
    nix-tree
    nvd
  ];
}
