{ pkgs, ... }:
let
  include = script: import script { inherit pkgs; };

  packages = [
    (include ./waybar-debugger.nix)
  ];
in
{
  config.environment.systemPackages = packages;
}
