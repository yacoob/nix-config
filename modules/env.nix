{ lib, vars, ... }: {
  home.sessionVariables = {
    LANG = "en_IE.UTF-8";
    LC_COLLATE = "pl_PL.UTF-8";
    LC_CTYPE = "pl_PL.UTF-8";
    LC_MESSAGES = "C.UTF-8";

    TZ = "Europe/Dublin";
    EMAIL = vars.email;
    LESS = "-iSRM";
    TMPDIR = "/tmp";

    CLAUDE_CODE_NO_FLICKER = "1";
    LIBPROC_HIDE_KERNEL = "1";
    PIP_REQUIRE_VIRTUALENV = "true";
  };

  xdg.configFile."environment.d/qt_font_scaling.conf" = lib.mkIf (lib.flavourAtLeast "desktop") {
    text = "QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor\n";
  };
}
