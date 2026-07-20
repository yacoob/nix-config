{ lib, pkgs, ... }:
{
  systemd.user = {
    tmpfiles.rules = [ "d %h/workarea 0750 - - -" ];
  } // lib.optionalAttrs (lib.flavourAtLeast "desktop") {
    services.gh-pr-count = {
      Unit = {
        Description = "Check outstanding GitHub PR count";
        After = "network-online.target";
        Wants = "network-online.target";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "gh-pr-count" ''
          ${pkgs.gh}/bin/gh search prs --involves "$(${pkgs.gh}/bin/gh api user --jq .login)" \
            --state open --json url --jq length > "$HOME/.cache/gh-pr-count" 2>/dev/null \
            || echo 0 > "$HOME/.cache/gh-pr-count"
        ''}";
      };
      Install.WantedBy = [ "default.target" ];
    };

    timers.gh-pr-count = {
      Unit = {
        Description = "Periodically check GitHub PRs";
        Requires = "gh-pr-count.service";
      };
      Timer = {
        OnBootSec = "1min";
        OnUnitActiveSec = "5min";
        Persistent = true;
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
