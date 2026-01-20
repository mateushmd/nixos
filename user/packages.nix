{ pkgs, inputs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      wezterm
      kitty

      vim
      git
      zip
      unzip
      libsecret 

      fzf
      bat
      gparted
      eza
      fastfetch
      btop
      sops

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
  ];
}
