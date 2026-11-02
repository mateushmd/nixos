{ lib, config, ... }: 
let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.custom;
in
{
  options.custom = {
    desktop = {
      hyprland = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Whether to enable the Hyprland Wayland compositor.";
        };

        config = mkOption {
          type = types.str;
          default = "";
          description = "The Hyprland configuration file to be used.";
        };
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
        description = "Whether to enable Heroic Game Launcher.";
      };
    };

    hyprpaper = {
      enable = mkEnableOption "Whether to enable Hyprpaper";
      config = mkOption {
        type = types.str;
        default = "";
        description = "The Hyprpaper configuration file to be used.";
      };
    };

    rootPasswordFile = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    terminal = {
      wezterm.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable Wezterm.";
      };

      kitty.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable Kitty.";
      };
    };

    sops.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Sops.";
    };

    laptop.enable = mkEnableOption 
      "Laptop-specific power and hardware settings.";

    waybar = {
      enable = mkEnableOption "Whether to enable Waybar.";

      config = mkOption {
        type = types.str;
        default = "";
        description = "The Waybar configuration file to be used.";
      };

      style = mkOption {
        type = types.str;
        default = "";
        description = "The Waybar stylesheet file to be used.";
      };
    };

    wifi.enable = mkEnableOption "Whether to enable WiFi profiles.";

    bluetooth.enable = mkEnableOption "Bluetooth support.";

    nano.enable = mkEnableOption "Whether to enable the nano text editor.";
  };

  config = {
    custom.desktop.hyprland.enable = 
      mkIf (cfg.desktop.defaultDE == "hyprland") true;
    custom.desktop.niri.enable = 
      mkIf (cfg.desktop.defaultDE == "niri") true;
    custom.desktop.plasma.enable = 
      mkIf (cfg.desktop.defaultDE == "plasma") true;
  };
}
