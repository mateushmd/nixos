{ myLib, ... }:
{
  imports = myLib.scanDirs ./.;

  system.stateVersion = "24.11";
}
