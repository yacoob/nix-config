{
  description = "my dotfiles in home-manager flavour";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixpkgs, home-manager, lazyvim, plasma-manager, ... }:
    {
      homeConfigurations."yacoob" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./home.nix
          lazyvim.homeManagerModules.default
          plasma-manager.homeModules.plasma-manager
        ];
      };
    };
}
