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
      vars = import ./vars.nix;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkFlavour =
        flavour:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit vars; };
          modules = [
            { flavour.name = flavour; }
            ./home.nix
            lazyvim.homeManagerModules.default
            plasma-manager.homeModules.plasma-manager
          ];
        };

      flavours = nixpkgs.lib.genAttrs vars.flavoursInOrder mkFlavour;
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;
      homeConfigurations = flavours // {
        ${vars.userName} = flavours.${vars.defaultFlavour};
      };
    };
}
