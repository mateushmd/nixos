{ config, pkgs, ... }:
{
  users = {
    mutableUsers = false;
    users = {
      mateus = {
        isNormalUser = true;
        description = "mateus";
        hashedPasswordFile = config.sops.secrets.user-password.path;
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "libvrtd"
          "docker"
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
