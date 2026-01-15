{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.custom.laptop;
in
{
  options.custom.laptop.enable = mkEnableOption "Enable laptop settings";

  config = mkIf cfg.enable {
    services = {
      power-profiles-daemon.enable = false;
      thermald.enable = true;
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    };

    systemd.tmpfiles.rules = 
      map (e: "w /sys/bus/${e}/power/control - - - - auto") [
        "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
        "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
        "pci/devices/0000:00:14.0" # FCH SMBus Controller
        "pci/devices/0000:00:14.3" # FCH LPC bridge
        "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
        "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
        "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
        "usb/devices/1-3" # USB camera
      ];
  };
}
