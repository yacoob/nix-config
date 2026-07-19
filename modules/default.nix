{ flavour, lib, ... }: {
  imports = [
    ./env.nix
    ./packages.nix

    ./fish.nix
    ./fishy-friends.nix
    ./starship.nix

    ./neovim.nix

    ./git.nix
    ./jujutsu.nix
    ./ssh.nix
    ./systemd.nix
    ./assorted_tools.nix
  ]
  ++ lib.optionals (flavour == "desktop") [
    ./plasma.nix
    ./scripts.nix
    ./terminal.nix
  ];
}
