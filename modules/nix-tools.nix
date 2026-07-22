{
  lib,
  pkgs,
  config,
  ...
}:
{
  home.packages =
    with pkgs;
    lib.optionals (config.flavour.atLeast "base") [ nh ]
    ++ lib.optionals (config.flavour.atLeast "desktop") [
      nix-inspect
      nix-tree
      nvd
    ];
}
