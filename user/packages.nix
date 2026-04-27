{ pkgs, inputs, ... }:
{
  environment.systemPackages = builtins.attrValues {
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
      gcolor3
      cisco-packet-tracer_9;
  } ++ [
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.kdePackages.kcalc
  ];
}
