{ inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "waybar-config.json";
    styName = "style.css";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./waybar-config.json;
      description = "Waybar configuration file content.";
    };

    options."${styName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./style.css;
      description = "Waybar style file content";
    };

    config = {
      package = config.pkgs.waybar;
      flags."-c" = toString config."${confName}".path;
      flags."-s" = toString config."${styName}".path;
    };
  }
)
