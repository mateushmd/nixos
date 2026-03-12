{ pkgs, ... }:
{
#  fonts.packages = [
#    pkgs.nerd-fonts.jetbrains-mono
#  ];

  fonts.packages = builtins.attrValues {
    inherit (pkgs)
      jetbrains-mono;
  } ++ [ pkgs.nerd-fonts.jetbrains-mono ];
}
