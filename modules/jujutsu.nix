{ lib, pkgs, vars, ... }: lib.mkIf (lib.flavourAtLeast "base") {
  home.packages = [ pkgs.jjui ];

  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = vars.fullName;
        inherit (vars) email;
      };
      signing = {
        behavior = "drop";
        key = vars.sshKey;
        backend = "ssh";
        backends.ssh.allowed-signers = "~/.ssh/allowedSigners";
      };
      ui = {
        default-command = "status";
        diff-formatter = ":git";
        pager = "delta";
        show-cryptographic-signatures = true;
      };
      aliases = {
        tug = [ "bookmark" "move" "--from" "closest_bookmark(@)" "--to" "closest_pushable(@)" ];
        mine = [ "bookmark" "list" "-r" "mine()" ];
      };
      revset-aliases = {
        my_work = "present(@) | ancestors(mine() ~ ::trunk(), 3) | present(trunk())";
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
        "closest_pushable(to)" = ''heads(::to & ~description(exact:"") & (~empty() | merges()))'';
      };
      git = {
        colocate = true;
        sign-on-push = true;
      };
      remotes.origin.auto-track-bookmarks = "glob:*";
      templates.log = "builtin_log_comfortable";
    };
  };
}
