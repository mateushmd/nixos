{ nixpkgs, self, ... } @ inputs: 
let
  inherit (self) configModules utilityFuncs;
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules = [
        {
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }
        ./${name}
      ] ++ builtins.attrValues configModules;

      specialArgs = {
        inherit inputs utilityFuncs;
      };
    };
in
{
  phalanx = mkHost "phalanx" "x86_64-linux";
}
