{ config, ... }:
let
  cfg = config.custom;
in
{
  config.services.displayManager = {
    sddm.enable = true;
    defaultSession = cfg.desktop.defaultDE;
  };
}
