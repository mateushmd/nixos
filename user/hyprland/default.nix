{ config, lib, pkgs, ... }:
let
  inherit (lib) mkOption mkIf types;
  cfg = config.custom.hyprland;
in
{
  options.custom.hyprland.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable the Hyprland Wayland compositor and related tools.";
  };

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
