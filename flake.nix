{
  description = "Was it really worth it?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    wrappers = { 
      url = "github:lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

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
    { nix-flatpak, nixpkgs, ... }@inputs:
    let
      myLib = import ./myLib.nix { pkgs = nixpkgs; };

      configModules = {
        system = import ./system;
        user = import ./user;
        wrapped = import ./wrapped;
        scripts = import ./scripts;
        nix-flatpak = nix-flatpak.nixosModules.nix-flatpak;
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
