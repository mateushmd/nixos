{ utilityFuncs, ... }:
{
  imports = (utilityFuncs.scanDirs ./.) ++ [ ./packages.nix ./options.nix ];
}
