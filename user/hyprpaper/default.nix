{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.hyprpaper;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      (config.custom.wrapped.hyprpaper.apply {
        "hyprpaper.conf".content = cfg.config;
      }).wrapper
    ];
  };
}
