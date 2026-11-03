{ lib, config, ... }: 
let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.custom;

  mkEnableOptionWithDefault = default: description: mkOption {
    inherit default description;
    type = types.bool;
  };

  mkWrapped = { enableDescription, configDescription }: {
    enable = mkEnableOptionWithDefault false enableDescription;
    config = mkOption {
      type = types.str;
      default = "";
      description = configDescription;
    };
  };
in
{
  options.custom = {
    desktop = {
      hyprland = mkWrapped {
        enableDescription = "Whether to enable the Hyprland Wayland compositor.";
        configDescription = "The Hyprland configuration file to be used.";
      };

      niri.enable = mkEnableOptionWithDefault false "Whether to enable the Niri Wayland compositor.";

      plasma.enable = mkEnableOptionWithDefault false "Whether to enable the KDE Plasma 6 Desktop Environment.";

      defaultDE = mkOption {
        type = types.nullOr (types.enum [ "hyprland" "niri" "plasma" ]);
        default = "hyprland";
        description = "The default desktop environment. Setting this will auto-enable the DE.";
      };
    };

    gaming = {
      steam.enable = mkEnableOptionWithDefault false "Whether to enable Steam.";
      heroic.enable = mkEnableOptionWithDefault false "Whether to enable Heroic Game Launcher.";
    };

    hyprpaper = mkWrapped {
      enableDescription = "Whether to enable Hyprpaper.";
      configDescription = "The Hyprpaper configuration file to be used.";
    };

    kitty = mkWrapped {
      enableDescription = "Whether to enable Kitty.";
      configDescription = "The Kitty configuration file to be used.";
    };

    rootPasswordFile = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    sops.enable = mkEnableOptionWithDefault true "Whether to enable Sops.";

    laptop.enable = mkEnableOption 
      "Laptop-specific power and hardware settings.";

    unity.enable = mkEnableOptionWithDefault false "Whether to enable Unity and associated packages";

    waybar = mkWrapped {
      enableDescription = "Whether to enable Waybar.";
      configDescription = "The Waybar configuration file to be used.";
    } // {
      style = mkOption {
        type = types.str;
        default = "";
        description = "The Waybar stylesheet file to be used.";
      };
    };

    wezterm = mkWrapped {
      enableDescription = "Whether to enable Wezterm.";
      configDescription = "The Wezterm configuration file to be used.";
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
