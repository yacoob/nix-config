{
  config,
  lib,
  vars,
  ...
}:
let
  # helper function for flavour enumeration
  indexOf =
    flavour:
    lib.lists.findFirstIndex (
      x: x == flavour
    ) (throw "unknown flavour: ${flavour}") vars.flavoursInOrder;
in
{
  options.flavour = {
    name = lib.mkOption {
      type = lib.types.enum vars.flavoursInOrder;
      description = "Flavour of the config currently being built.";
    };

    atLeast = lib.mkOption {
      type = lib.types.functionTo lib.types.bool;
      readOnly = true;
      description = "Whether the active flavour ranks at or above the given one.";
    };
  };
  config.flavour.atLeast = target: indexOf config.flavour.name >= indexOf target;
}
