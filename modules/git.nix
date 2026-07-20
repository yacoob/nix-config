{
  config,
  lib,
  vars,
  ...
}:
{
  home.file.".ssh/allowedSigners".text = ''
    ${vars.email} ${vars.sshKey}
  '';

  programs = {
    git = {
      enable = true;

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
  // lib.optionalAttrs (lib.flavourAtLeast "base") {
    mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };

    lazygit = {
      enable = true;
      settings = {
        git = {
          overrideGpg = true;
          autoFetch = false;
        };
        gui = {
          nerdFontsVersion = "3";
          theme = {
            activeBorderColor = [
              "#ff9e64"
              "bold"
            ];
            inactiveBorderColor = [ "#27a1b9" ];
            searchingActiveBorderColor = [
              "#ff9e64"
              "bold"
            ];
            optionsTextColor = [ "#7aa2f7" ];
            selectedLineBgColor = [ "#283457" ];
            cherryPickedCommitFgColor = [ "#7aa2f7" ];
            cherryPickedCommitBgColor = [ "#bb9af7" ];
            markedBaseCommitFgColor = [ "#7aa2f7" ];
            markedBaseCommitBgColor = [ "#e0af68" ];
            unstagedChangesColor = [ "#db4b4b" ];
            defaultFgColor = [ "#c0caf5" ];
          };
        };
      };
    };
  };
}
