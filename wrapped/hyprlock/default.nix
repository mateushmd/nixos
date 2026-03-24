{ inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "hyprlock.conf";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./hyprlock.conf;
      description = "Hyprlock configuration file content.";
    };

    config = {
      package = config.pkgs.hyprlock;
      flags."-c" = toString config."${confName}".path;
    };
  }
)
