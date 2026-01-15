{ config, inputs, ... }:
let
  ageKeyFile = "/var/lib/sops/age/keys.txt";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.variables.SOPS_AGE_KEY_FILE = ageKeyFile;

  sops = {
    defaultSopsFile = "${inputs.self}/secrets/${config.networking.hostName}/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = ageKeyFile;

    secrets.user-password = {
      neededForUsers = true;
    };
  };
}
