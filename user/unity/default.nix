{ pkgs, ... }: 
{
  environment.systemPackages = [
    pkgs.dotnetCorePackages.sdk_10_0
  ];
  
  services.flatpak.packages = [
    "com.unity.UnityHub"
  ];
}
