{ utilityFuncs, ... }:
{
  /*
  imports = [
    ./audio
    ./bluetooth
    ./boot
    ./fonts
    ./kde
    ./keyboard
    ./locale
    ./networking
    ./nix
    ./ssh
    ./sudo
    ./users
  ];
  */

  imports = utilityFuncs.scanDirs ./.;

  system.stateVersion = "24.11";
}
