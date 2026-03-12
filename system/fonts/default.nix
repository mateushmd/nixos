{ pkgs, ... }:
{
  fonts.packages = builtins.attrValues {
    inherit (pkgs)
      jetbrains-mono;
  } ++ [ pkgs.nerd-fonts.jetbrains-mono ];
}
