{ ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems = {
    "/mnt/pocket" = {
      label = "pocket";
      fsType = "ext4";
      options = [ 
        "nofail" 
        "noatime" 
        "exec" 
      ];
    };
  }; 
}
