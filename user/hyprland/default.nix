{ config, lib, myLib, pkgs, ... }:
let
  inherit (lib) mkIf;

  wallpapers = myLib.fetchWallpapers {
    owner = "mateushmd";
    repo = "wallpapers";
    rev = "243fdade1cdbed900dbac3eba24ea3668f6e846c";
  };

  wrappers = 
  let
    hyprpaper-wrapper = (wrapped.hyprpaper.apply {
      "hyprpaper.conf".content = ''
        wallpaper {
          monitor =
          path = ${wallpapers."1.png"}
          fit_mode = cover
        }
      '';
    }).wrapper;
  in [  
    wrapped.hyprland.wrapper
    hyprpaper-wrapper
    wrapped.hypridle.wrapper
    wrapped.hyprlock.wrapper
    wrapped.waybar.wrapper
  ];

  cfg = config.custom.desktop.hyprland;
  wrapped = config.custom.wrapped;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        rofi;
    } ++ wrappers;

    programs.uwsm.waylandCompositors.hyprland = { 
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "${wrapped.hyprland.wrapper}/bin/hyprland-wrapped";
    };
  };
}
