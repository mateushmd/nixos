{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.custom.nano;
in
{
  options.custom.nano.enable = mkEnableOption "Enables nano";

  config.programs.nano.enable = mkIf (!cfg.enable) false;
}
