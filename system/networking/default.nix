{ config, lib, ... }:
let
  cfg = config.custom;
in
{
  config.networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" ];

    networkmanager = {
      enable = true;
      dns = "none";
    } // lib.optionalattrs cfg.wifi.enable {
      ensureprofiles = {
        environmentfiles = [ config.sops.secrets.wifi-env.path ];
        profiles = import ./wifi.nix { inherit lib; };
      };
    };

    firewall.trustedInterfaces = [ "virbr0" ];
  };
}
