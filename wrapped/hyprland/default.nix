{ lib, inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "hyprland.conf";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./hyprland.conf;
      description = "Hyprland configuration file content.";
    };

    config = {
      package = config.pkgs.hyprland;
      flags."-c" = toString config."${confName}".path;
    };
  }
)
