{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];
  };
}
