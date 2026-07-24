{ inputs, pkgs, ... }:
let
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
      default.content = builtins.readFile ./hyprland.lua;
      description = "Hyprland configuration file content.";
    };

    config = {
      package = package;
      flags."-c" = toString config."${confName}".path;
    };
  }
)
