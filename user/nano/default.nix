{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.custom.nano;
in
{
  options.custom.nano.enable = mkEnableOption "the nano text editor";

  config.programs.nano.enable = mkIf (!cfg.enable) false;
}
