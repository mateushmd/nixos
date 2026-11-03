{ config, lib, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.wezterm;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      (config.custom.wrapped.wezterm.apply {
        ".wezterm.lua".content = cfg.config;
      }).wrapper
    ];
  };
}
