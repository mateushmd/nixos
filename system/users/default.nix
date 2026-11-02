{ config, pkgs, ... }:
let
  cfg = config.custom.rootPasswordFile;
  hostName = config.networking.hostName;
in
{
  users = {
    mutableUsers = false;
    users = {
      mateus = {
        isNormalUser = true;
        description = "mateus";
        hashedPasswordFile = config.sops.secrets."${hostName}/user-password".path;
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "libvirtd"
          "docker"
          "kvm"
        ];
        uid = 1000;
      };
      puddo = {
        isNormalUser = true;
        extraGroups = [
          "libvirtd"
          "wheel"
        ];  
      };
      root = if cfg != null
        then { hashedPasswordFile = cfg; }
        else { hashedPassword = "!"; };
    };
  };
}
