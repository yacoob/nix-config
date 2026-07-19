{ vars, ... }: {
  home.file.".ssh/authorized_keys".text = ''
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHhf94VluQZY5JTdsx4JVGJCUQa1LdCXDVAsjHkm3bAkAAAABHNzaDo=
    sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFUgnlRzqVppYGS1R5YvCAg/soHTpLh83Pr1lYZ/Ix9LAAAABHNzaDo=
    ${vars.sshKey} ${vars.email}
  '';
}
