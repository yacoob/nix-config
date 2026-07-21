{
  lib,
  pkgs,
  vars,
  config,
  ...
}:
{
  # only build the locales actually referenced across the config (see LC_* below
  # and plasma-localerc); the default glibcLocales is the full ~220 MiB archive
  i18n.glibcLocales = pkgs.glibcLocales.override {
    allLocales = false;
    locales = [
      "en_IE.UTF-8/UTF-8"
      "pl_PL.UTF-8/UTF-8"
      "en_CA.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
    ];
  };

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

  xdg.configFile."environment.d/qt_font_scaling.conf" = lib.mkIf (config.flavour.atLeast "desktop") {
    text = "QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor\n";
  };
}
