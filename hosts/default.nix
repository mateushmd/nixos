{ configModules, inputs, myLib }: 
let
  inherit (inputs) nixpkgs;

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
        inherit inputs myLib;
      };
    };
in
{
  phalanx = mkHost "phalanx" "x86_64-linux";
}
