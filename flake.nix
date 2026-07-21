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
    {
      nixpkgs,
      home-manager,
      lazyvim,
      plasma-manager,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      vars = import ./vars.nix;

      flavoursInOrder = [
        "minimal"
        "base"
        "desktop"
      ];

      flavourIndex =
        flavour:
        lib.lists.findFirstIndex (x: x == flavour) (throw "unknown flavour: ${flavour}") flavoursInOrder;

      flavourAtLeast = flavour: target: flavourIndex flavour >= flavourIndex target;

      mkFlavour =
        flavour:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit vars;
            flavourAtLeast = flavourAtLeast flavour;
          };
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
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
