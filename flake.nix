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
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      apps.${system}.hyprstubs = {
        type = "app";
        program = let 
          genScript = pkgs.writeShellScriptBin "gen-stubs" ''
            SRC_DIR=${hyprland-source}
            TARGET_DIR="./stubs"
            mkdir -p "$TARGET_DIR"
            ${pkgs.python3}/bin/python3 "$SRC_DIR/meta/generateLuaStubs.py" --output "$TARGET_DIR/hyprland.meta.lua"
            echo "Hyprland Lua stubs successfully generated at $TARGET_DIR"
          '';
        in "${genScript}/bin/gen-stubs";
      };
      
      configModules = {
        system = import ./system;
        user = import ./user;
        wrapped = import ./wrapped;
      };

      myLib = import ./lib pkgs;

      nixosConfigurations = import ./hosts inputs;
    };
}
