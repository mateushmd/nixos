{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  custom = {
    laptop.enable = true;
    bluetooth.enable = true;
  };
}
