{ lib, pkgs, ... }: lib.mkIf (lib.flavourAtLeast "base") {
  programs = {
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        keymap_mode = "vim-insert";
        filter_mode = "host";
        sync.records = true;
      };
    };

    bat = {
      enable = true;
      config = {
        theme = "tokyonight_night";
        style = "plain";
      };
      themes.tokyonight_night = {
        src = pkgs.vimPlugins.tokyonight-nvim;
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };

    eza = {
      enable = true;
      icons = "auto";
      extraOptions = [
        "--color-scale"
        "all"
        "--hyperlink"
        "--group-directories-first"
      ];
    };

    fd.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = false; # fzf.fish owns the keybinds
      defaultCommand = "fd --type file --color=always";
      historyWidget.command = "";
      defaultOptions = [
        "--height ~40%"
        "--reverse"
        "--inline-info"
        "--ansi"
        "--highlight-line"
        "--info=inline-right"
        "--layout=reverse"
        "--border=none"
      ];
      colors = {
        "bg+" = "#1E222A";
        "bg" = "#1A1D23";
        "border" = "#3A3E47";
        "fg" = "#ADB0BB";
        "gutter" = "#1A1D23";
        "header" = "#50A4E9";
        "hl+" = "#5EB7FF";
        "hl" = "#5EB7FF";
        "info" = "#3A3E47";
        "marker" = "#5EB7FF";
        "pointer" = "#5EB7FF";
        "prompt" = "#5EB7FF";
        "query" = "#ADB0BB:regular";
        "scrollbar" = "#3A3E47";
        "separator" = "#3A3E47";
        "spinner" = "#5EB7FF";
      };
    };

    ripgrep.enable = true;

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
