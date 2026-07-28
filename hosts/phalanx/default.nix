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

    terminal = {
      wezterm.enable = true;
      kitty.enable = true;
    };

    laptop.enable = true;
    bluetooth.enable = true;
  };
}
