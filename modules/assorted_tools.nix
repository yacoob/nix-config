{
  lib,
  pkgs,
  flavourAtLeast,
  ...
}:
lib.mkIf (flavourAtLeast "base") {
  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = false; # no systemd timer
    settings.updates.auto_update = true; # update opportunistically on run
  };

  home = {
    packages = with pkgs; [
      gdu
      just
    ];

    file = {
      # aptitude
      ".aptitude/config".text = ''
        aptitude "";
        aptitude::Keep-Unused-Pattern "";
        aptitude::Delete-Unused-Pattern "";
        aptitude::Auto-Upgrade "true";
        aptitude::Delete-Unused "true";
        aptitude::AutoClean-After-Update "true";
        aptitude::UI "";
        aptitude::UI::Flat-View-As-First-View "true";
        aptitude::UI::Package-Display-Format "%c%a%M%S %p %t %O %Z %v %V";
        aptitude::Pkg-Display-Limit "~i";
        APT "";
        APT::Install-Recommends "false";
      '';

      # ipython
      ".ipython/profile_default/ipython_config.py".text = ''
        c = get_config()  # noqa
        c.InteractiveShellApp.extensions = ["autoreload"]
        c.InteractiveShellApp.exec_lines = ["%autoreload 1"]
      '';

      # markdownlint-cli2
      ".markdownlint-cli2.yaml".text = ''
        config:
          MD013: false
      '';
    };
  };

}
