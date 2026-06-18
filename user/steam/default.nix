{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.custom.gaming;
in
{ 
  options.custom.steam.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable Steam.";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
