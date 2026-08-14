{ config, lib, myLib, ... }:
let
  cfg = config.custom;
in
{
  config.networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" ];

    networkmanager = {
      enable = true;
      dns = "none";
    } // lib.optionalAttrs cfg.wifi.enable {
      ensureProfiles = {
        environmentFiles = [ config.sops.secrets.wifi-env.path ];
        profiles = import ./wifi.nix { inherit lib myLib; };
      };
    };

    firewall.trustedInterfaces = [ "virbr0" ];
  };
}
