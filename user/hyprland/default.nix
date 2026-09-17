{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.desktop.hyprland;
  wrapped = config.custom.wrapped;

  hyprland = wrapped.hyprland.apply {
    "hyprland.lua".content = cfg.hyprlandConfig;
  };

  hyprpaper = wrapped.hyprpaper.apply {
    "hyprpaper.conf".content = cfg.hyprpaperConfig;
  };
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        rofi
        brightnessctl
        playerctl
        pavucontrol
        mako
        libnotify;
    } ++ [
      hyprland.wrapper
      hyprpaper.wrapper
      wrapped.waybar.wrapper
    ];

    programs.uwsm.waylandCompositors.hyprland = { 
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "${hyprland.wrapper}/bin/hyprland-wrapped";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [ "hyprland" "gtk" ];
        };
      };
    };
  };
}
