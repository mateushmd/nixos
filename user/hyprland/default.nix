{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.desktop.hyprland;

  hyprland = (config.custom.wrapped.hyprland.apply {
    "hyprland.lua".content = cfg.config;
  }).wrapper;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      hyprland
    ];

    programs.uwsm.waylandCompositors.hyprland = { 
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "${hyprland}/bin/hyprland-wrapped";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk 
        pkgs.xdg-desktop-portal-hyprland
      ];
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
