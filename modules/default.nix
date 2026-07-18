{ flavour, lib, ... }: {
  imports = [
    ./env.nix
    ./packages.nix

    ./fish.nix
    ./fishy-friends.nix
    ./starship.nix

    ./neovim.nix
  ]
  ++ lib.optionals (flavour == "desktop") [ ./plasma.nix ];
}
