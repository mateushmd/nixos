{ pkgs, utilityFuncs, ... }:
{
  imports = (utilityFuncs.scanDirs ./.) ++ [./packages.nix];
}
