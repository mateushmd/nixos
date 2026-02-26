{ pkgs, utilityFuncs, ... }:
let
  inherit (pkgs) callPackage;
  packages = import ./wrapped/hyprland;
in
{
  imports = (utilityFuncs.scanDirs ./.) ++ [./packages.nix];

  environment.systemPackages = builtins.attrValues packages;
}
