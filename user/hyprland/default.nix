{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.desktop.hyprland;
  wrapped = config.custom.wrapped;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        rofi;
    } ++ [
      wrapped.hyprland.wrapper
      wrapped.hyprpaper.wrapper
      wrapped.hypridle.wrapper
      wrapped.hyprlock.wrapper
      wrapped.waybar.wrapper
    ];

    programs.uwsm.waylandCompositors.hyprland = { 
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "${wrapped.hyprland.wrapper}/bin/hyprland-wrapped";
    };
  };
}
