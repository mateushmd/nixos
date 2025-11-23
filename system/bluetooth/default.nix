{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.custom.bluetooth;
in 
{
  options.custom.bluetooth.enable = mkEnableOption "Enables bluetooth support";
  
  config.hardware.bluetooth = mkIf cfg.enable {
    enable = true;
    powerOnBoot = false;
  };
}
