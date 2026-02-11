{ lib, pkgs, wrappers, ... }:
let
  hyprModule = pname:
    wrappers.lib.wrapModule (
      { config, lib, wlib, ... }:
      let
        confName = "${pname}.conf";
      in
      {
        name = "${pname}-wrapped";

        options."${confName}" = lib.mkOption {
          type = wlib.types.file config.pkgs;
        };

        config = {
          flags."-c" = config."${confName}".path;
        };
      }
    );

  mkHyprApp = pkg:
    (hyprModule pkg.pname).apply {
      inherit pkgs;
      package = pkg;
      "${pkg.pname}.conf".content = ./config/${pkg.pname}.conf;
    };

  apps = [ "hyprland" "hyprpaper" ];
in
lib.genAttrs apps ( name: (mkHyprApp pkgs.${name}).wrapper )
