{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkIf;

  waybar-reloader = pkgs.writeShellBinScript "waybar-reloader" ''
    while true; do
      ${pkgs.inotify-tools}/bin/inotifywait -q -e create,modify ./../../wrapped/waybar
      ${pkgs.procps}/bin/pkill -USR2 waybar
    done
  '';

  cfg = config.custom.desktop.hyprland;
  wrapped = config.custom.wrapped;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        rofi
        brightnessctl
        playerctl;
    } ++ [
      wrapped.hyprland.wrapper
      (wrapped.hyprpaper.apply {
        "hyprpaper.conf".content = ''
          wallpaper {
              monitor =
              path = ~/repos/wallpapers/1.png
              fit_mode = cover
          }

          splash = false
        '';
      }).wrapper
      wrapped.hypridle.wrapper
      wrapped.hyprlock.wrapper
      wrapped.waybar.wrapper
      waybar-reloader
    ];

    programs.uwsm.waylandCompositors.hyprland = { 
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "${wrapped.hyprland.wrapper}/bin/hyprland-wrapped";
    };
  };
}
