{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkOption optional types;
  cfg = config.custom.heroic;
in
{
  options.custom.heroic.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable Heroic Game Launcher.";
  };

  config.environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      # must have
      wezterm
      kitty
      vim
      git
      
      # cli tools
      libsecret 
      gemini-cli
      zip
      unzip
      fzf
      bat
      gparted
      eza
      fastfetch
      btop
      sops
      qemu
      fd
      ripgrep
      tldr

      # apps
      discord
      obsidian
      anydesk
      vlc
      aseprite
      audacity
      gimp3-with-plugins
      gcolor3;
  } ++ [
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.kdePackages.kcalc
  ] ++ optional cfg.enable pkgs.heroic;
}
