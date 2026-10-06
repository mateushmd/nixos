{ inputs, pkgs, ... }: 
let
  inherit (inputs) nix-claude-code;
in
{
  nixpkgs.overlays = [ nix-claude-code.overlays.default ];
  environment.systemPackages = [ pkgs.claude-code ];
}
