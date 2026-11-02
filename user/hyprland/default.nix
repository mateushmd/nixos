{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.desktop.hyprland;
  wrapped = config.custom.wrapped;

  hyprland = wrapped.hyprland.apply {
    "hyprland.lua".content = cfg.config;
  };
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      (config.custom.wrappedd.hyprland.apply {
        "hyprland.lua".content = cfg.config;
      }).wrapper
    ];

    programs.uwsm.waylandCompositors.hyprland = { 
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "${hyprland.wrapper}/bin/hyprland-wrapped";
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
