{ ... }:
{
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

  services.printing.enable = true;

  system.stateVersion = "24.11";
}
