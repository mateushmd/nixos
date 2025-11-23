{ config, lib, ... }:
let 
  inherit (lib) mkOption mkIf types;

  cfg = config.custom.firefox;
in
{
  options.custom.firefox.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enables Firefox";
  };

  config.programs.firefox.enable = mkIf cfg.enable true;
}
