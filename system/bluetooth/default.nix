{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.custom.bluetooth;
in 
{
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    
    services = { 
      blueman.enable = true;
      pipewire.wireplumber.extraConfig."10-bluez"."monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ 
          "a2dp_sink" 
          "a2dp_source" 
        ];
        "bluez5.autoswitch-profile" = false;
      };
    };
  };
}
