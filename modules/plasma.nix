{ lib, pkgs, ... }:
lib.mkIf (lib.flavourAtLeast "desktop") {
  # KZones KWin script (its settings and shortcuts live in programs.plasma below).
  home.packages = [ pkgs.kdePackages.kzones ];

  programs.plasma = {
    enable = true;

    workspace.lookAndFeel = "org.kde.breezedark.desktop";

    configFile = {
      kcminputrc = {
        "ButtonRebinds/Mouse".ExtraButton4 = "Key,Meta+Tab";
        Keyboard = {
          RepeatDelay = 250;
          RepeatRate = 30;
        };
      };
      kdeglobals = {
        General = {
          TerminalApplication = "ghostty --gtk-single-instance=true";
          TerminalService = "com.mitchellh.ghostty.desktop";
          XftAntialias = true;
          XftHintStyle = "hintslight";
          XftSubPixel = "rgb";
          fixed = "FiraCode Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        };
        KDE = {
          contrast = 4;
          frameContrast = 0.2;
        };
        KScreen.ScreenScaleFactors = "eDP-1=1;";
        WM = {
          activeBackground = "39,44,49";
          activeBlend = "252,252,252";
          activeForeground = "252,252,252";
          inactiveBackground = "32,36,40";
          inactiveBlend = "161,169,177";
          inactiveForeground = "161,169,177";
        };
      };
      krunnerrc = {
        Plugins = {
          baloosearchEnabled = true;
          bazaarrunnerEnabled = false;
          krunner_appstreamEnabled = true;
        };
        "Plugins/Favorites".plugins = "krunner_services";
      };
      kscreenlockerrc.Daemon = {
        LockGrace = 30;
        Timeout = 10;
      };
      kwinrc = {
        Desktops = {
          Number = 3;
          Rows = 1;
        };
        Effect-hidecursor.InactivityDuration = 5;
        Effect-overview.BorderActivate = 9;
        Plugins = {
          dimscreenEnabled = true;
          fadeEnabled = true;
          hidecursorEnabled = true;
          kzonesEnabled = true;
          scaleEnabled = false;
          wobblywindowsEnabled = true;
        };
        Script-kzones = {
          enableEdgeSnapping = true;
          fadeWindowsWhileMoving = true;
          layoutsJson = "[\n    {\n        \"name\": \"Priority Grid\",\n        \"padding\": 0,\n        \"zones\": [\n            {\n                \"x\": 0,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 25\n            },\n            {\n                \"x\": 25,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 50\n            },\n            {\n                \"x\": 75,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 25\n            }\n        ]\n    },\n  {\n        \"name\": \"Half-and-half\",\n        \"zones\": [\n            {\n                \"x\": 0,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 50\n            },\n            {\n                \"x\": 50,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 50\n            }\n        ]\n    },\n    {\n        \"name\": \"Quadrant Grid\",\n        \"zones\": [\n            {\n                \"x\": 0,\n                \"y\": 0,\n                \"height\": 50,\n                \"width\": 50\n            },\n            {\n                \"x\": 0,\n                \"y\": 50,\n                \"height\": 50,\n                \"width\": 50\n            },\n            {\n                \"x\": 50,\n                \"y\": 50,\n                \"height\": 50,\n                \"width\": 50\n            },\n            {\n                \"x\": 50,\n                \"y\": 0,\n                \"height\": 50,\n                \"width\": 50\n            }\n        ]\n    }\n]";
        };
        TabBox.LayoutName = "big_icons";
        Windows = {
          ElectricBorderMaximize = false;
          ElectricBorderTiling = false;
        };
      };
      kxkbrc.Layout = {
        DisplayNames = "";
        LayoutList = "pl";
        Options = "caps:escape_shifted_capslock";
        ResetOldOptions = true;
        Use = true;
        VariantList = "";
      };
      plasma-localerc = {
        Formats = {
          LANG = "en_IE";
          LC_ADDRESS = "en_IE.UTF-8";
          LC_MEASUREMENT = "en_IE.UTF-8";
          LC_MONETARY = "en_IE.UTF-8";
          LC_NAME = "en_IE.UTF-8";
          LC_NUMERIC = "en_IE.UTF-8";
          LC_PAPER = "en_IE.UTF-8";
          LC_TELEPHONE = "en_IE.UTF-8";
          LC_TIME = "en_CA.UTF-8";
        };
        Translations.LANGUAGE = "en_GB";
      };
      plasmaparc.General.AudioFeedback = false;
    };

    shortcuts = {
      "com.mitchellh.ghostty"."ALT+space" = "Alt+Space";
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+L"
        ];
        "Log Out" = "Ctrl+Alt+Del";
      };
      kwin = {
        "Edit Tiles" = [ ];
        Expose = "Ctrl+F9";
        ExposeAll = [
          "Launch (C)"
          "Ctrl+F10"
        ];
        ExposeClass = "Ctrl+F7";
        "KZones: Activate layout 1" = "Meta+Num+1";
        "KZones: Activate layout 2" = "Meta+Num+2";
        "KZones: Activate layout 3" = "Meta+Num+3";
        "KZones: Activate layout 4" = "Meta+Num+4";
        "KZones: Activate layout 5" = "Meta+Num+5";
        "KZones: Activate layout 6" = "Meta+Num+6";
        "KZones: Activate layout 7" = "Meta+Num+7";
        "KZones: Activate layout 8" = "Meta+Num+8";
        "KZones: Activate layout 9" = "Meta+Num+9";
        "KZones: Cycle layouts" = "Ctrl+Alt+D";
        "KZones: Cycle layouts (reversed)" = "Ctrl+Alt+Shift+D";
        "KZones: Move active window down" = [ ];
        "KZones: Move active window left" = [ ];
        "KZones: Move active window right" = [ ];
        "KZones: Move active window to next zone" = "Meta+Right";
        "KZones: Move active window to previous zone" = "Meta+Left";
        "KZones: Move active window to zone 1" = "Ctrl+Alt+Num+1";
        "KZones: Move active window to zone 2" = "Ctrl+Alt+Num+2";
        "KZones: Move active window to zone 3" = "Ctrl+Alt+Num+3";
        "KZones: Move active window to zone 4" = "Ctrl+Alt+Num+4";
        "KZones: Move active window to zone 5" = "Ctrl+Alt+Num+5";
        "KZones: Move active window to zone 6" = "Ctrl+Alt+Num+6";
        "KZones: Move active window to zone 7" = "Ctrl+Alt+Num+7";
        "KZones: Move active window to zone 8" = "Ctrl+Alt+Num+8";
        "KZones: Move active window to zone 9" = "Ctrl+Alt+Num+9";
        "KZones: Move active window up" = [ ];
        "KZones: Snap active window" = "Meta+Up";
        "KZones: Snap all windows" = "Meta+Space";
        "KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
        "KZones: Switch to previous window in current zone" = "Ctrl+Alt+Down";
        "KZones: Toggle zone overlay" = "Ctrl+Alt+C";
        Overview = [
          "Meta+W"
          "Meta+Tab"
        ];
        "Switch to Desktop 1" = "Ctrl+F1";
        "Switch to Desktop 2" = "Ctrl+F2";
        "Switch to Desktop 3" = "Ctrl+F3";
        "Switch to Desktop 4" = "Ctrl+F4";
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows of Current Application" = "Alt+`";
        "Walk Through Windows of Current Application Alternative" = [ ];
        "Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "Walk Through Windows of Current Application (Reverse)" = "Alt+~";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Window Quick Tile Bottom" = [ ];
        "Window Quick Tile Bottom Left" = [ ];
        "Window Quick Tile Bottom Right" = [ ];
        "Window Quick Tile Left" = [ ];
        "Window Quick Tile Right" = [ ];
        "Window Quick Tile Top" = [ ];
        "Window Quick Tile Top Left" = [ ];
        "Window Quick Tile Top Right" = [ ];
      };
      org_kde_powerdevil = {
        Sleep = [
          "Sleep"
          "Meta+Shift+L"
        ];
        "Turn Off Screen" = "Meta+Ctrl+L";
      };
      plasmashell = {
        "next activity" = "Meta+A";
        "previous activity" = "Meta+Shift+A";
        "activate application launcher" = "Alt+F1";
      };

      "services/com.mitchellh.ghostty.desktop"._launch = [ ];
      "services/org.kde.konsole.desktop"._launch = [ ];
      "services/org.kde.krunner.desktop"._launch = [
        "Meta"
        "Search"
        "Alt+F2"
      ];
      "services/org.kde.touchpadshortcuts.desktop".ToggleTouchpad = [
        "Touchpad Toggle"
        "Meta+Ctrl+Zenkaku Hankaku"
      ];
    };
  };
}
