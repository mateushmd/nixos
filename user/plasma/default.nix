{ config, lib, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.custom.plasma;
in
{
  options.custom.plasma.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enables Plasma 6 Desktop Environment";
  };

  config.services = mkIf cfg.enable {
    displayManager.sddm.enable = true;
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
