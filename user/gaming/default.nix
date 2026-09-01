{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.custom.gaming;
in
{
  config = mkIf (cfg.steam.enable || cfg.heroic.enable ) {
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };
}
