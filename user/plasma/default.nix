{ config, lib, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.custom.desktop.plasma;
in
{
  config.services = mkIf cfg.enable {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
        variant = "";
      };
    };
  };
}
