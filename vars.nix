{
  userName = "yacoob";
  fullName = "Jakub Turski";
  email = "yacoob@ftml.net";
  sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFn7Jo4qNc92Gh/ZmiD87QTqruvA/3XaaLKWkaFPpZR+";

  # flavours in ascending order of richness; modules gate on
  # config.flavour.atLeast, see modules/flavour.nix
  flavoursInOrder = [
    "minimal"
    "base"
    "desktop"
  ];
  defaultFlavour = "desktop";
}
