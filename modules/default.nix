{ flavour, lib, ... }: {
  imports = [
    ./env.nix
    ./packages.nix

    ./fish.nix
    ./fishy-friends.nix
    ./starship.nix

    ./neovim.nix

    ./git.nix
  ]
  ++ lib.optionals (flavour == "desktop") [ ./plasma.nix ./gh-pr-count.nix ];
}
