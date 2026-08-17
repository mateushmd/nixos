{ config, inputs, pkgs, ... }:
let
  sysConfig = config;

  package = inputs.wrappers.lib.wrapPackage {
    inherit pkgs;
    package = pkgs.hyprland;
    exePath = "${pkgs.hyprland}/bin/Hyprland";
    binName = "hyprland-wrapped";
  };
in
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "hyprland.lua";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = ''
        ${builtins.readFile ./hyprland.lua}

        ${if sysConfig.custom.laptop.enable then 
          builtins.readFile ./laptop.lua 
        else ""}

        ${if sysConfig.networking.hostName == "phalanx" then 
          builtins.readFile ./phalanx.lua 
        else throw "No configuration for ${sysConfig.networking.hostName}"}
      '';
      description = "Hyprland configuration file content.";
    };

    config = {
      package = package;
      flags."-c" = toString config."${confName}".path;
    };
  }
)
