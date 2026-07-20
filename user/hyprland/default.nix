{ config, lib, pkgs, ... }:
let
  inherit (lib) mkOption mkIf types;
  cfg = config.custom.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        rofi;
    } ++ [
      config.custom.wrapped.hyprland.wrapper
      config.custom.wrapped.hyprpaper.wrapper
      config.custom.wrapped.hypridle.wrapper
      config.custom.wrapped.hyprlock.wrapper
      config.custom.wrapped.waybar.wrapper
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
