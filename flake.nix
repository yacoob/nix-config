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
    let
      inherit (nixpkgs) lib;
      vars = import ./vars.nix;

      flavoursInOrder = [ "minimal" "base" "desktop" ];

      flavourAtLeast = flavour: target:
        lib.lists.findFirstIndex (x: x == flavour) null flavoursInOrder
        >= lib.lists.findFirstIndex (x: x == target) null flavoursInOrder;

      mkFlavour = flavour: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        lib = lib.extend (_: _: { flavourAtLeast = flavourAtLeast flavour; });
        extraSpecialArgs = { inherit flavour vars; };
        modules = [
          ./home.nix
          lazyvim.homeManagerModules.default
          plasma-manager.homeModules.plasma-manager
        ];
      };

      flavours = lib.genAttrs flavoursInOrder mkFlavour;
    in
    {
      homeConfigurations = flavours // {
        ${vars.userName} = flavours.${vars.defaultFlavour};
      };
    };
}
