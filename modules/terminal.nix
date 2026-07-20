{ lib, pkgs, ... }: lib.mkIf (lib.flavourAtLeast "desktop") {
  # FiraCode Nerd Font — bundled with the terminal that uses it
  fonts.fontconfig.enable = true;
  home.packages = [ pkgs.nerd-fonts.fira-code ];

  # config only — use the OS ghostty (/usr/sbin/ghostty), matching the KDE terminal setting
  programs.ghostty = {
    enable = true;
    package = null;
    systemd.enable = false;

    settings = {
      # looks
      font-family = "FiraCode Nerd Font Mono";
      font-size = 12;
      theme = "TokyoNight Night";
      gtk-wide-tabs = false;
      gtk-toolbar-style = "flat";

      # io pressure reported (incorrectly?) with io_uring
      # https://github.com/ghostty-org/ghostty/discussions/3224
      async-backend = "epoll";

      # behaviour
      bell-features = "border";
      command = "fish -l";
      confirm-close-surface = false;
      copy-on-select = "clipboard";
      maximize = false;
      shell-integration-features = "no-cursor,ssh-env";
      cursor-style = "block";

      keybind = [
        ''shift+enter=text:\x1b\r''
        "global:alt+space=toggle_quick_terminal"
        "alt+n=new_split:auto"
        "alt+shift+d=new_split:down"
        "alt+shift+r=new_split:right"
        "alt+l=goto_split:right"
        "alt+j=goto_split:down"
        "alt+k=goto_split:up"
        "alt+h=goto_split:left"
        "alt+bracket_right=goto_split:next"
        "alt+bracket_left=goto_split:previous"
        "alt+equal=equalize_splits"
        "alt+f=toggle_split_zoom"
        "alt+x=close_surface"
      ];
    };
  };
}
