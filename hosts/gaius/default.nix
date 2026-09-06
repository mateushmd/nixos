{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  system.stateVersion = "26.05";

  custom = {
    desktop = {
      hyprland.enable = true;
      plasma.enable = true;
      defaultDE = "hyprland";
    };

    terminal = {
      wezterm.enable = true;
      kitty.enable = true;
    };

    nano.enable = false;
  };
}
