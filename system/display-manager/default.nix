{ config, ... }:
let
  cfg = config.custom;
in
{
  config.services.displayManager = {
    sddm.enable = true;
    defaultSession =
      if cfg.desktop.defaultDE == "hyprland" then
        "hyprland-uwsm"
      else if cfg.desktop.defaultDE == "plasma" then
        "plasma"
      else { };
  };
}
