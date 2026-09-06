{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  hostName = config.networking.hostName;
in
{
  users = {
    mutableUsers = false;
    users = {
      mateus = {
        isNormalUser = true;
        description = "mateus";
        # hashedPasswordFile = mkIf config.custom.sops.enable config.sops.secrets."${hostName}/user-password".path;
        initialPassword = "123";
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "libvrtd"
          "docker"
          "kvm"
        ];
        uid = 1000;
      };
      puddo = {
        isNormalUser = true;
        extraGroups = [
          "libvrtd"
          "wheel"
        ];  
      };
      root = {
        initialPassword = "123";
      };
    };
  };
}
