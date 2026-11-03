{ config, lib, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.kitty;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      (config.custom.wrapped.kitty.apply {
        "kitty.conf".content = cfg.config;
      }).wrapper
    ];
  };
}
