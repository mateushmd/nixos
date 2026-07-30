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

      # flags."-c" = toString config."${confName}".path;
      # flags."-s" = toString config."${styName}".path;

      args = [ "\${FINAL_ARGS[@]}" ];

      preHook = ''
        STORE_CONFIG="${toString config."${confName}".path}"
        STORE_STYLE="${toString config."${styName}".path}"

        HAS_CONFIG=0
        HAS_STYLE=0

        for arg in "$@"; do
          if [ "$arg" = "-c" ]; then HAS_CONFIG=1; fi
          if [ "$arg" = "-s" ]; then HAS_STYLE=1; fi
        done

        FINAL_ARGS=()

        if [ "$HAS_CONFIG" -eq 0 ]; then
          FINAL_ARGS+=("-c" "$STORE_CONFIG")
        fi

        if [ "$HAS_STYLE" -eq 0 ]; then
          FINAL_ARGS+=("-s" "$STORE_STYLE")
        fi
      '';
    };
  }
)
