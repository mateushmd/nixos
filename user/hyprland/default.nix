{ config, lib, ... }:
let
  inherit (lib) mkOption mkIf types;
  cfg = config.custom.hyprland;
in
{
  options.custom.hyprland.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enables Hyprland";
  };

  config = mkIf cfg.enable {
    /*
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
    };
    */
  };
}
