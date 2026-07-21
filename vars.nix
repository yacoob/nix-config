{
  userName = "yacoob";
  fullName = "Jakub Turski";
  email = "yacoob@ftml.net";
  sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFn7Jo4qNc92Gh/ZmiD87QTqruvA/3XaaLKWkaFPpZR+";
  fidoKeys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHhf94VluQZY5JTdsx4JVGJCUQa1LdCXDVAsjHkm3bAkAAAABHNzaDo="
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFUgnlRzqVppYGS1R5YvCAg/soHTpLh83Pr1lYZ/Ix9LAAAABHNzaDo="
  ];

  # flavours in ascending order of richness; modules gate on
  # config.flavour.atLeast, see modules/flavour.nix
  flavoursInOrder = [
    "minimal"
    "base"
    "desktop"
  ];
  defaultFlavour = "desktop";
}
