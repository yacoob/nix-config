{ ... }: {
  programs.starship = {
    enable = true;
    presets = [ "nerd-font-symbols" ];
    settings = {
      format = "$time$custom$line_break$all$line_break$character";
      cmd_duration.show_milliseconds = true;
      hostname = {
        ssh_only = false;
        format = "[@](red)[$hostname]($style) in ";
        style = "yellow";
      };
      shlvl = {
        disabled = false;
        threshold = 5;
        symbol = " ";
      };
      status = {
        disabled = false;
        pipestatus = true;
      };
      time = {
        disabled = false;
        format = "[󱑎 ](red)[$time]($style) ";
        style = "italic white";
        time_format = "%T %a %b-%0e";
      };
      username = {
        aliases = {
          "yacoob" = "";
        };
        show_always = true;
        format = "[$user]($style)";
        style_user = "yellow";
      };
      kubernetes.disabled = false;
      battery.display = [
        {
          threshold = 15;
          style = "blink red";
        }
        {
          threshold = 33;
          style = "yellow";
        }
        {
          threshold = 66;
          style = "dimmed green";
        }
      ];
    };
  };
}


