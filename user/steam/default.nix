{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [
      pkgs.proto-ge-bin
    ];
  };
}
