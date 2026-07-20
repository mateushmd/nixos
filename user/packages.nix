{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) optional;
  cfg = config.custom.gaming.heroic;
in
{
  config.environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      # must have
      wezterm
      kitty
      vim
      git
      
      # cli tools
      libsecret 
      antigravity-cli
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
