{ vars, ... }: {
  imports = [ ./modules ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  home = {
    stateVersion = "26.05";
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
  };
}
