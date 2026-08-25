{ pkgs, ... }:
{
  /*
  imports = [
    "${modulesPath}/virtualisation/qemu-vm.nix"
  ];
  */


  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    docker.enable = true;
    spiceUSBRedirection.enable = true;

    /*
    vmVariant = {
      virtualisation = { 
        sharedDirectories = {
          sops-keys = {
            source = "/var/lib/sops";
            target = "/var/lib/sops";
          };
        };
        memorySize = 4096;  
        cores = 4;
      };
    };
    */
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
