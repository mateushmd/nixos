{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  system.stateVersion = "24.11";

  time.timeZone = "Europe/Rome";

  environment.systemPackages = [
    pkgs.gamescope
  ];

  environment.variables.NEWT_COLORS = "root=#FFFFFF,#000000 border=#FF00FF,#000000 window=#000000,#000000 shadow=#000000,#000000 title=#FF00FF,#000000 button=#000000,#FF00FF button_active=#000000,#FFFF00 actbutton=#FFFF00,#000000 compactbutton=#FFFF00,#000000 checkbox=#FF0000,#000000 entry=#00FF00,#000000 disentry=#000000,#000000 textbox=#00FF00,#000000 acttextbox=#FF00FF,#000000 label=#00FFFF,#000000 listbox=#00FF00,#000000 actlistbox=#FF00FF,#000000 sellistbox=#FF0000,#000000 actsellistbox=#000000,#FFFF00";

  custom = {
    desktop = {
      hyprland = {
        enable = true;
        hyprlandConfig = builtins.readFile ./hyprland.lua;
        hyprpaperConfig = builtins.readFile ./hyprpaper.conf;
      };
      plasma.enable = true;
      defaultDE = "hyprland";
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
    wifi.enable = true;
    bluetooth.enable = true;
    nano.enable = false;
  };
}
