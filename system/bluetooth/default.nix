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
  options.custom.bluetooth.enable = mkEnableOption "Bluetooth support";
  
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    
    services.blueman.enable = true;
  };
}
