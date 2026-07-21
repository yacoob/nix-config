{ lib, vars, ... }:
{
  # With SELinux enforcement on, sshd may not read a file labeled nix_store_t, so it silently
  # ignores keys reached through a store symlink. Keep the store-linked list as
  # authorized_keys_nix and copy it into a real authorized_keys, which inherits ssh_home_t from ~/.ssh.
  home.file.".ssh/authorized_keys_nix".text = ''
    ${lib.concatStringsSep "\n" vars.fidoKeys}
    ${vars.sshKey} ${vars.email}
  '';

  home.activation.sshAuthorizedKeys = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run install $VERBOSE_ARG -C -Dm600 "$HOME/.ssh/authorized_keys_nix" "$HOME/.ssh/authorized_keys"
  '';
}
