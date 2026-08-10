{ ... }:
{
  security.sudo.extraRules = [
    {
      commands = map (command: {
        command = "/run/current-system/sw/bin/${command}";
        options = [ "NOPASSWD" ];
      }) [ "nixos-rebuild" ];
      groups = [ "wheel" ];
    }
  ];
}
