{ config, lib, ... }:
let 
  inherit (lib) mkOption mkIf types;

  cfg = config.custom.firefox;
in
{
  options.custom.firefox.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable the Firefox web browser.";
  };

  config.programs.firefox.enable = mkIf cfg.enable true;
}
