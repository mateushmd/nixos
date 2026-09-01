{ ... }: 
{
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
  };
}
