{ config, lib, ... }:
let
  cfg = config.custom.desktop.niri;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = config.custom.wrapped.niri.wrapper;
  };
}
