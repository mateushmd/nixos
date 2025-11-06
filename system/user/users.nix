{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
    users = {
      mateus = {
        isNormalUser = true;
        description = "mateus";
        shell = pkgs.fish;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        uid = 1000;
      };
    };
  };
}
