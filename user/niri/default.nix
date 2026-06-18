{ config, lib, pkgs, ... }:
let
  inherit (lib) mkOption mkIf types;
  cfg = config.custom.niri;
in
{
  options.custom.niri.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable the Niri Wayland compositor.";
  };
  
  /*
  config = mkIf cfg.enable {
    environment.systemPackages = config.custom.wrapped.niri.wrapper;
  };
  */
}
