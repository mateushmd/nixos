{ myLib, ... }:
{
  imports = (myLib.scanDirs ./.) ++ [ ./packages.nix ];
}
