{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkMerge [

  (lib.mkIf (!(config.flavour.atLeast "base")) {
    home.shell.enableBashIntegration = true;

    programs.bash = {
      enable = true;
      package = null;
      enableCompletion = false;
    };
  })

  (lib.mkIf (config.flavour.atLeast "base") {
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
      ];

      shellInit = lib.mkMerge [
        ''
          umask 027
          fish_add_path --path ~/.local/bin
          set -gx SHELL $(type -P fish)
        ''
        (lib.mkIf (config.flavour.atLeast "desktop") ''
          if not set -q SSH_AUTH_SOCK
              set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
          end
        '')
      ];

      interactiveShellInit = ''
        set -g fish_greeting
        set -g fish_key_bindings fish_vi_key_bindings

        # color theme: TokyoNight
        source ${pkgs.vimPlugins.tokyonight-nvim}/extras/fish/tokyonight_night.fish

        # editor
        if command -q nvim
            set -gx EDITOR nvim
            set -gx VISUAL nvim
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
        kctx = "kubert ctx";
        kns = "kubert ns";
        refish = "exec fish";
        update-all = "sudo dnf update --refresh --assumeyes && flatpak update -y";
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
        humanize-seconds = ''
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
        '';
      };
    };
  })
]
