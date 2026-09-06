{ config, inputs, lib, ... }:
let
  inherit (lib) mkIf;
  hostName = config.networking.hostName;
  ageKeyFile = "/var/lib/sops/age/keys.txt";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = mkIf config.custom.sops.enable {
    environment.variables.SOPS_AGE_KEY_FILE = ageKeyFile;
  
    sops = {
      defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
      defaultSopsFormat = "yaml";
      age.keyFile = ageKeyFile;
  
      secrets = {
        "${hostName}/user-password" = {
          neededForUsers = true;
        };
  
        wifi-env = {
          mode = "0600";
        };
      };
    };
  };
}
