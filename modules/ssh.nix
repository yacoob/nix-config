{ lib, vars, ... }:
{
  # With SELinux enforcement on, sshd may not read a file labeled nix_store_t, so it silently
  # ignores keys reached through a store symlink. Keep the store-linked list as
  # authorized_keys_nix and copy it into a real authorized_keys, which inherits ssh_home_t from ~/.ssh.
  home.file.".ssh/authorized_keys_nix".text = ''
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHhf94VluQZY5JTdsx4JVGJCUQa1LdCXDVAsjHkm3bAkAAAABHNzaDo=
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFUgnlRzqVppYGS1R5YvCAg/soHTpLh83Pr1lYZ/Ix9LAAAABHNzaDo=
    ${vars.sshKey} ${vars.email}
  '';

  home.activation.sshAuthorizedKeys = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run install $VERBOSE_ARG -C -Dm600 "$HOME/.ssh/authorized_keys_nix" "$HOME/.ssh/authorized_keys"
  '';
}
