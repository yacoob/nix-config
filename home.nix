{ config, pkgs, ... }:

{
  home.username = "yacoob";
  home.homeDirectory = "/home/yacoob";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = [];
  home.file = {};
  home.sessionVariables = {};

  programs.home-manager.enable = true;
  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.fd.enable = true;
  programs.eza.enable = true;
}
