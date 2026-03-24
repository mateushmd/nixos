{ inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "hypridle.conf";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./hypridle.conf;
      description = "Hypridle configuration file content";
    };

    config = {
      package = config.pkgs.hypridle;
      flags."-c" = toString config."${confName}".path;
    };
  }
)
