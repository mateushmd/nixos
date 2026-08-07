{ myLib, ... }:
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

  imports = myLib.scanDirs ./.;

  system.stateVersion = "24.11";
}
