{
  description = "This should not exist";

  inputs = {
    nixos-wsl.url = "github:nix-community/nixos-wsl/main";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:mateushmd/nixvim";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default 
        {
          imports = [ ./configuration.nix ];

          wsl.enable = true;
          wsl.defaultUser = "mateus";
          system.stateVersion = "25.05"; 
        }
      ];
    };
  };
}
