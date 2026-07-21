{ pkgs, ... }: {
  programs.fish = {
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
}
