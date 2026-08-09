{
  description = "Was it really worth it?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    wrappers.url = "github:lassulus/wrappers";

    nixvim = {
      url = "github:mateushmd/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-source = {
      url = "github:hyprwm/Hyprland";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, hyprland-source, ... }@inputs:
    let
      myLib = import ./myLib.nix nixpkgs;
    in
    {
      inherit myLib;

      apps = myLib.forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          script = pkgs.writeShellScriptBin "gen-stubs" ''
            SRC_DIR=${hyprland-source}
            TARGET_DIR="./stubs"
            mkdir -p "$TARGET_DIR"
            ${pkgs.python3}/bin/python3 "$SRC_DIR/meta/generateLuaStubs.py" --output "$TARGET_DIR/hyprland.meta.lua"
            echo "Hyprland Lua stubs successfully generated at $TARGET_DIR"
          '';
        in {
          hyprstubs = {
            type = "app";
            program = "${script}/bin/gen-stubs";
          };
        }
      );

      configModules = {
        system = import ./system;
        user = import ./user;
        wrapped = import ./wrapped;
      };

      formatter = myLib.forAllSystems (system: 
        nixpkgs.legacyPackages.${system}.nixfmt
      );

      nixosConfigurations = import ./hosts inputs;
    };
}
