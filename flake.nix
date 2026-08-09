{
  description = "Was it really worth it?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    wrappers = { 
      url = "github:lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:mateushmd/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      myLib = import ./myLib.nix nixpkgs;

      configModules = {
        system = import ./system;
        user = import ./user;
        wrapped = import ./wrapped;
      };

      forAllSystems = nixpkgs.lib.genAttrs [
          "x86_64-linux" 
          "aarch64-linux" 
          "aarch64-darwin"
      ];

      mkHyprstubsApp = pkgs: {
        type = "app";
        program =
          let
            script = pkgs.writeShellApplication {
              name = "gen-hypr-stubs";
              runtimeInputs = [ pkgs.python3 ];
              text = ''
                SRC_DIR="${pkgs.hyprland.src}"
                TARGET_DIR="./stubs"
                mkdir -p "$TARGET_DIR"
                python3 "$SRC_DIR/meta/generateLuaStubs.py" --output "$TARGET_DIR/hyprland.meta.lua"
                echo "Hyprland Lua stubs successfully generated at $TARGET_DIR"
              '';
            };
          in
          "${script}/bin/gen-hypr-stubs";
        meta = {
          description = "Generate Lua stubs for Hyprland";
          mainProgram = "gen-hypr-stubs";
        };
      };

    in
    {
      apps = forAllSystems (system: {
        hyprstubs = mkHyprstubsApp nixpkgs.legacyPackages.${system};
      });

      formatter = forAllSystems (system: 
        nixpkgs.legacyPackages.${system}.nixfmt-tree
      );

      nixosConfigurations = import ./hosts { 
        inherit configModules inputs myLib; 
      };
    };
}
