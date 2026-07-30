{ config, lib, ... }:
let
  inherit (lib) mkIf;

  cfg = config.custom.nano;
in
{
  config.programs.nano.enable = mkIf (!cfg.enable) false;
}
