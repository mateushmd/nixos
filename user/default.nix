{ myLib, ... }:
{
  imports = (myLib.scanDirs ./.) ++ [ ./packages.nix ./options.nix ];
}
