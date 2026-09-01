{ myLib, ... }:
{
  imports = (myLib.scanDirs ./.) ++ [ ./packages.nix ./flatpak.nix ];
}
