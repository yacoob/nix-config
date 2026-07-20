{ lib, pkgs, ... }: lib.mkIf (lib.flavourAtLeast "desktop") {
  # assorted local scripts, dropped into ~/.local/bin

  # DELL U4025QW input switcher (notify-send comes from the desktop)
  home.packages = [ pkgs.ddcutil ];

  home.file.".local/bin/u4025qw-kvm-flip.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh

      MODEL='DELL U4025QW'
      notify() { notify-send "$1" "$2" --app-name="Input switch" --icon=video-display; }

      if ! command -v ddcutil >/dev/null 2>&1; then
        notify "Failed to switch" "ddcutil is not installed"
        exit 1
      fi

      current=$(ddcutil --model "$MODEL" getvcp 60 --brief 2>/dev/null | cut -d\  -f4)
      if [ -z "$current" ]; then
        notify "$MODEL not found" "Currently connected:\n$(ddcutil detect | grep 'Model:')"
        exit 1
      fi

      if [ "$current" = "x19" ]; then
        next='x0f'
      else
        next='x19'
      fi

      ddcutil --model "$MODEL" setvcp 60 "$next" 2>/dev/null
    '';
  };
}
