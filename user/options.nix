{ lib, config, ... }: 
let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.custom;
in
{
  options.custom = {
    desktop = {
      hyprland.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable the Hyprland Wayland compositor and 
          related tools.";
      };

      niri.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable the Niri Wayland compositor.";
      };

      plasma.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable the KDE Plasma 6 Desktop Environment.";
      };

      defaultDE = mkOption {
        type = types.nullOr (types.enum [ "hyprland" "niri" "plasma" ]);
        default = "hyprland";
        description = "The default desktop environment. Setting this will
          auto-enable the DE.";
      };
    };

    gaming = {
      steam.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable Steam.";
      };

      heroic.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whther to enable Heroic Game Launcher.";
      };
    };

    terminal = {
      wezterm.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable Wezterm";
      };

      kitty.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable Kitty";
      };
    };

    laptop.enable = mkEnableOption "Laptop-specific power and hardware
      settings";

    bluetooth.enable = mkEnableOption "Bluetooth support";
  };

  config = {
    custom.desktop.hyprland.enable = mkIf (cfg.desktop.defaultDE == "hyprland") true;
    custom.desktop.niri.enable = mkIf (cfg.desktop.defaultDE == "niri") true;
    custom.desktop.plasma.enable = mkIf (cfg.desktop.defaultDE == "plasma") true;
  };
}
