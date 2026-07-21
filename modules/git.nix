{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  home = {
    file.".ssh/allowedSigners".text = ''
      ${vars.email} ${vars.sshKey}
    '';

    # lazygit merges its config files; layer tokyonight's theme extra over ours
    sessionVariables = lib.optionalAttrs (config.flavour.atLeast "base") {
      LG_CONFIG_FILE = "${pkgs.vimPlugins.tokyonight-nvim}/extras/lazygit/tokyonight_night.yml,${config.xdg.configHome}/lazygit/config.yml";
    };
  };

  programs = {
    git = {
      enable = true;
      package = pkgs.gitMinimal;

      settings = {
        user = {
          name = vars.fullName;
          inherit (vars) email;
          signingkey = vars.sshKey;
        };

        alias = {
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
          branch-name = "!git rev-parse --abbrev-ref HEAD";
          publish = "!git push -u origin $(git branch-name)";
          unpublish = "!git push origin :$(git branch-name)";
          diffc = "diff --cached";
          push-everywhere = "!git remote | xargs -L1 git push";
          push-all = "!git remote | xargs -L1 git push --all";
        };

        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowedSigners";
        };
        column.ui = "auto";
        color.ui = true;
        init.defaultBranch = "main";
        core = {
          editor = "nvim";
          fsmonitor = true;
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        push = {
          default = "matching";
          autoSetupRemote = true;
          followTags = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
        pull.rebase = true;
        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };
        difftool.prompt = false;
        mergetool = {
          prompt = false;
          keepBackup = false;
        };
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        help.autocorrect = "prompt";
        commit = {
          verbose = true;
          gpgsign = true;
        };
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        credential.helper = [
          "cache --timeout 21600"
          "oauth"
        ];
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        dark = true;
        features = "unobtrusive-line-numbers decorations";
        hyperlinks = true;
      };
    };
  }
  // lib.optionalAttrs (config.flavour.atLeast "base") {
    mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };

    lazygit = {
      enable = true;
      # gui block (theme + nerdFontsVersion) comes from tokyonight via LG_CONFIG_FILE
      settings.git = {
        overrideGpg = true;
        autoFetch = false;
      };
    };
  };
}
