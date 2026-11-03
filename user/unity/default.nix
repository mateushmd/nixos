{ config, lib, pkgs, ... }: 
let
  inherit (lib) mkIf;
  cfg = config.custom.unity;
in
{
  config = mkIf cfg.enable { 
    environment.systemPackages = [
      pkgs.dotnetCorePackages.sdk_10_0
    ];
    
    services.flatpak.packages = [
      "com.unity.UnityHub"
    ];
  };
}
