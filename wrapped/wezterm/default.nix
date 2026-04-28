{ inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = ".wezterm.lua";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = builtins.readFile ./.wezterm.lua;
      description = "Wezterm configuration file content.";
    };

    config = {
      package = config.pkgs.wezterm;
      flags."--config-file" = toString config."${confName}".path;
    };
  }
)
