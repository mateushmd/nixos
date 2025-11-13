{ ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
        variant = "";
      };
    };
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = true;
  };
}
