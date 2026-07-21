{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf (config.flavour.atLeast "base") {
  # fzf colors: grab tokyonight's extras sh snippet for fzf, sed it down to a plain
  # options file and put the resulting file's path in FZF_DEFAULT_OPTS_FILE
  home.sessionVariables.FZF_DEFAULT_OPTS_FILE = pkgs.runCommandLocal "fzf-tokyonight-night" { } ''
    sed -n 's/^ *\(--color=[^ ]*\).*/\1/p' ${pkgs.vimPlugins.tokyonight-nvim}/extras/fzf/tokyonight_night.sh > $out
  '';

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
        "--ansi"
        "--highlight-line"
        "--info=inline-right"
        "--layout=reverse"
        "--border=none"
      ];
    };

    ripgrep.enable = true;

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
