{ inputs, ... }:
inputs.wrappers.lib.wrapModule (
  { config, lib, wlib, ... }:
  let
    confName = "kitty.conf";
  in
  {
    options."${confName}" = lib.mkOption {
      type = wlib.types.file config.pkgs;
      default.content = ''
        ${builtins.readFile ./tokyo-night.conf}
        ${builtins.readFile ./kitty.conf}
      '';
      description = "Kitty configuration file content.";
    };

    config = {
      package = config.pkgs.kitty;
      flags."--config" = toString config."${confName}".path;
    };
  }
)
