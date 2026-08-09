{ ... }:
{
  security.sudo = {
    extraConfig = ''
      Defaults env_keep += "SSH_AUTH_SOCK"
    '';

    extraRules = [
      {
        commands = builtins.map (command: {
          command = "/run/current-system/sw/bin/${command}";
          options = [ "NOPASSWD" ];
        }) [ "nixos-rebuild" ];
        groups = [ "wheel" ];
      }
    ];
  };
}
