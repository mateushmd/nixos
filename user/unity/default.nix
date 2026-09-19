{ pkgs, ... }: 
{
  environment.systemPackages = [
    pkgs.dotnet-sdk
  ];
  
  services.flatpak.packages = [
    "com.unity.UnityHub"
  ];
}
