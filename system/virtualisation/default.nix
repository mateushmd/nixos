{ pkgs, ... }:
{
  /*
  imports = [
    "${modulesPath}/virtualisation/qemu-vm.nix"
  ];

  virtualisation = { 
    sharedDirectories = {
      sops-keys = {
        source = "/var/lib/sops";
        target = "/var/lib/sops";
      };
    };
    vmVariant.virtualisation = {
      memorySize = 4096;  
      cores = 4;
    };
  };
  */

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  systemd.services.libvirt-default-network = {
    description = "Start libvirt default network";
    after = ["libvirtd.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
      ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
      User = "root";
    };
  };
}
