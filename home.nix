{
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfreePredicate = _: true;

  home = {
    stateVersion = "26.05";
    username = "yacoob";
    homeDirectory = "/home/yacoob";
    packages = with pkgs; [
      gdu
      git
    ];
    sessionVariables = {
      LANG = "en_IE.UTF-8";
      LC_COLLATE = "pl_PL.UTF-8";
      LC_CTYPE = "pl_PL.UTF-8";
      LC_MESSAGES = "C.UTF-8";

      TZ = "Europe/Dublin";
      EMAIL = "yacoob@ftml.net";
      LESS = "-iSRM";
      TMPDIR = "/tmp";

      CLAUDE_CODE_NO_FLICKER = "1";
      LIBPROC_HIDE_KERNEL = "1";
      PIP_REQUIRE_VIRTUALENV = "true";
    };
  };

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

    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
      ];

      shellInit = ''
        umask 027
        fish_add_path --path ~/.local/bin

        if not set -q SSH_AUTH_SOCK
            set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
        end
        set -gx SHELL $(type -P fish)
      '';

      interactiveShellInit = ''
        set -g fish_greeting
        set -g fish_key_bindings fish_vi_key_bindings

        # fzf.fish key bindings
        fzf_configure_bindings --processes=ctrl-alt-i

        # color theme: TokyoNight
        # https://github.com/folke/tokyonight.nvim/blob/main/extras/fish/tokyonight_night.fish
        set -l foreground c0caf5
        set -l selection 283457
        set -l comment 565f89
        set -l red f7768e
        set -l orange ff9e64
        set -l yellow e0af68
        set -l green 9ece6a
        set -l purple 9d7cd8
        set -l cyan 7dcfff
        set -l pink bb9af7
        set -g fish_color_normal $foreground
        set -g fish_color_command $cyan
        set -g fish_color_keyword $pink
        set -g fish_color_quote $yellow
        set -g fish_color_redirection $foreground
        set -g fish_color_end $orange
        set -g fish_color_option $pink
        set -g fish_color_error $red
        set -g fish_color_param $purple
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_match --background=$selection
        set -g fish_color_operator $green
        set -g fish_color_escape $pink
        set -g fish_color_autosuggestion $comment
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $comment
        set -g fish_pager_color_selected_background --background=$selection

        # editor
        if command -q nvim
            set -gx EDITOR nvim
            set -gx VISUAL nvim
            alias vi nvim
            alias vim nvim
        else if command -q vim
            set -gx EDITOR vim
            set -gx VISUAL vim
            alias vi vim
        else
            set -gx EDITOR vi
            set -gx VISUAL vi
        end
      '';

      shellAbbrs = {
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        grep = "grep -E";
        la = "ls -A";
        ll = "ls -lh";
        lla = "ls -lhA";
        k = "kubectl";
        refish = "exec fish";
        update-all = "sudo dnf update --refresh --assumeyes && flatpak update -y";
        kctx = "kubert ctx";
        kns = "kubert ns";
        B = {
          position = "anywhere";
          expansion = "| bat -l yaml";
        };
        EO = {
          position = "anywhere";
          expansion = "2>&1 ";
        };
        L = {
          position = "anywhere";
          setCursor = true;
          expansion = "% | less";
        };
        G = {
          position = "anywhere";
          expansion = "| grep -E";
        };
        R = {
          position = "anywhere";
          expansion = "| rg";
        };
        W = {
          position = "anywhere";
          expansion = "| wl-copy";
        };
      };

      shellAliases = {
        apt-list-backports = ''aptitude search -t (lsb_release -sc)-backports -F "%p %v -> %V" "~U ~Abackports"'';
      };

      functions = {
        humanize-seconds = {
          body = ''
            function humanize-seconds
                set -l T $argv[1]
                set -l D (math -s0 "$T / 86400")
                set -l H (math -s0 "$T / 3600 % 24")
                set -l M (math -s0 "$T / 60 % 60")
                set -l S (math -s0 "$T % 60")

                set -l parts
                test $D -gt 0 && set -a parts "$D days"
                test $H -gt 0 && set -a parts "$H hours"
                test $M -gt 0 && set -a parts "$M minutes"
                set -a parts "$S seconds"

                if test (count $parts) -gt 1
                    echo (string join ' ' $parts[1..-2]) and $parts[-1]
                else
                    echo $parts[1]
                end
            end
          '';
        };
      };
    };

    fzf = {
      enable = true;
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

    home-manager.enable = true;
    ripgrep.enable = true;

    starship = {
      enable = true;
      presets = [ "nerd-font-symbols" ];
      settings = {
        format = "$time$custom$line_break$all$line_break$character";
        cmd_duration.show_milliseconds = true;
        hostname = {
          ssh_only = false;
          format = "[@](red)[$hostname]($style) in ";
          style = "yellow";
        };
        shlvl = {
          disabled = false;
          threshold = 5;
          symbol = " ";
        };
        status = {
          disabled = false;
          pipestatus = true;
        };
        time = {
          disabled = false;
          format = "[󱑎 ](red)[$time]($style) ";
          style = "italic white";
          time_format = "%T %a %b-%0e";
        };
        username = {
          aliases = {
            "yacoob" = "";
          };
          show_always = true;
          format = "[$user]($style)";
          style_user = "yellow";
        };
        kubernetes.disabled = false;
        battery.display = [
          {
            threshold = 15;
            style = "blink red";
          }
          {
            threshold = 33;
            style = "yellow";
          }
          {
            threshold = 66;
            style = "dimmed green";
          }
        ];
      };
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
