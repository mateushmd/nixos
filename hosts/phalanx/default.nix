{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  custom = {
    laptop.enable = true;
    bluetooth.enable = true;
    steam.enable = true;
    heroic.enable = true;
  };
}
