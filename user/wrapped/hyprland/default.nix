{ lib, inputs, ... }:
let
  apps = [ "hyprland" "hyprpaper" ];

  hyprModule = name:
    inputs.wrappers.lib.wrapModule (
      { config, lib, wlib, ... }:
      let
        confName = "${name}.conf";
      in
      {
        name = "${name}-wrapped";

        options."${confName}" = lib.mkOption {
          type = wlib.types.file config.pkgs;
          default.content = "";
        };

        config = {
          flags."-c" = config."${confName}".path;
        };
      }
    );

  mkHyprApp = pkg:
    (hyprModule pkg.pname).apply {
      inherit (inputs) nixpkgs;
      package = pkg;
      "${pkg.pname}.conf".content = ./config/${pkg.pname}.conf;
    };
in
lib.genAttrs apps ( name: (mkHyprApp inputs.nixpkgs.${name}).wrapper )
