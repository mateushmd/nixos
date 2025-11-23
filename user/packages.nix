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
      fzf
      bat
      gparted
      eza
      fastfetch
      btop
      discord
      obsidian
      anydesk
      vlc
      aseprite
      gimp3-with-plugins;
  } ++ [inputs.nixvim.packages.${pkgs.system}.default];
}
