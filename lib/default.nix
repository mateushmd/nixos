{ pkgs, ... }:
{
  scanDirs = import ./scanDirs.nix { inherit (pkgs) lib; };
  fetchWallpapers = import ./fetchWallpapers.nix pkgs;
}
