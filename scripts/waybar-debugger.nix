{ pkgs }:
pkgs.writeShellScriptBin "waybar-debugger" ''
  CONFIG_FILE="$1"
  STYLE_FILE="$2"

  if [ -z "$CONFIG_FILE" ]; then
    echo "Error: No config file provided."
    exit 1
  fi

  if [ -z "$STYLE_FILE" ]; then
    echo "Error: No style file provided."
    exit 1
  fi

  CONFIG_DIR=$(dirname "$(realpath "$CONFIG_FILE")")
  CONFIG_BASE=$(basename "$CONFIG_FILE")

  STYLE_DIR=$(dirname "$(realpath "$STYLE_FILE")")
  STYLE_BASE=$(basename "$STYLE_FILE")

  waybar -c "$CONFIG_FILE" -s "$STYLE_FILE" &
  WAYBAR_PID=$!

  trap "kill $WAYBAR_PID 2>/dev/null" EXIT

  ${pkgs.inotify-tools}/bin/inotifywait -m -e close_write -e moved_to "$CONFIG_DIR" "$STYLE_DIR" | while read -r path events file; do
    if [ "$file" = "$CONFIG_BASE" ] || [ "$file" = "$STYLE_BASE" ]; then
      echo "Alteração detectada em $file. Recarregando Waybar (PID: $WAYBAR_PID)..."
      kill -USR2 $WAYBAR_PID
    fi
  done
''
