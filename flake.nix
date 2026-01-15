{
  description = "Was it really worth it?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:mateushmd/nixvim";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
    in
    {
      configModules = {
        system = import ./system;
        user = import ./user;
      };

      utilityFuncs = {
        scanDirs = path:
          let
            entries = builtins.readDir path;

            dirs = lib.filterAttrs (name: type: type == "directory") entries;
          in
            lib.mapAttrsToList (name: _: path + "/${name}") dirs;
      };

      nixosConfigurations = import ./hosts inputs;

      /*
      nixosConfigurations.nixos = lib.nixosSystem {
        specialArgs = { 
          inherit inputs; 
        };

        modules = [
          ./configuration.nix
        ];
      };
      */
    };
}
