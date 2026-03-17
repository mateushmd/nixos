{ lib, inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "hyprpaper.conf";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./hyprpaper.conf;
      description = "Hyprpaper configuration file content.";
    };

    config = {
      package = config.pkgs.hyprpaper;
      flags."-c" = toString config."${confName}".path;
    };
  }
)
