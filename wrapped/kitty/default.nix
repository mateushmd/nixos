{ inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "kitty.conf";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      description = "Kitty configuration file content.";
    };

    config = {
      package = config.pkgs.kitty;
      flags."--config" = toString config."${confName}".path;
    };
  }
)
