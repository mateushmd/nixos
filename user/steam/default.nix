{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  cfg = config.custom.gaming.steam;
in
{ 
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
