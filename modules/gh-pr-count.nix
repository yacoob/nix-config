{ pkgs, ... }:
let
  gh = "${pkgs.gh}/bin/gh";
  script = pkgs.writeShellScript "gh-pr-count" ''
    ${gh} search prs --involves "$(${gh} api user --jq .login)" \
      --state open --json url --jq length > "$HOME/.cache/gh-pr-count" 2>/dev/null \
      || echo 0 > "$HOME/.cache/gh-pr-count"
  '';
in
{
  systemd.user.services.gh-pr-count = {
    Unit = {
      Description = "Check outstanding GitHub PR count";
      After = "network-online.target";
      Wants = "network-online.target";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${script}";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.gh-pr-count = {
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
}
