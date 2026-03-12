{ ... }:
{
  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        UseDns = true;
        PasswordAuthentication = true;
        AllowUsers = [ "puddo" ];
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
    tailscale.enable = true;
  };
}
