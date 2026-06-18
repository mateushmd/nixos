{ lib, pkgs, utilityFuncs, ... }:
{
  options.custom.gaming.enable = lib.mkEnableOption "Gaming support";

  imports = (utilityFuncs.scanDirs ./.) ++ [./packages.nix];
}
