{
  description = "Was it really worth it?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:mateushmd/nixvim";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix 
      ];
    };
  };
}
