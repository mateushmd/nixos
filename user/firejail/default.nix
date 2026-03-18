{ lib, pkgs, ... }:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      packettracer9 = {
        executable = lib.getExe pkgs.cisco-packet-tracer_9;
        desktop = "${pkgs.cisco-packet-tracer_9}/share/applications/cisco-packet-tracer-9.desktop";
        extraArgs = [
          "--net=none"
          "--noprofile"
        ];
      };
    };
  };
}
