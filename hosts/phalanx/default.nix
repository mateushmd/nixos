{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  custom = {
    desktop = {
      hyprland.enable = true;
      plasma.enable = true;
      defaultDE = "plasma";
    };

    gaming = {
      steam.enable = true;
      heroic.enable = true;
    };

    laptop.enable = true;
    bluetooth.enable = true;
  };
}
