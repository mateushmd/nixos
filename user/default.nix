{ utilityFuncs, ... }:
{
  imports = (utilityFuncs.scanDirs ./.) ++ [./packages.nix];
}
