pkgs:
let
  inherit (pkgs) lib;
in
{
  fetchWallpapers = { owner, repo, rev, hash }: 
  let
    source = pkgs.fetchFromGithub {
      inherit owner repo rev hash;
    };

    validExtensions = [ "png" "jpg" "jpeg" ];

    contents = builtins.readDir source;

    filtered = lib.filterAttrs (
      name: type:
        type == "regular" &&
        lib.elem (lib.last (lib.splitString "." name)) validExtensions
    ) contents;
  in
    lib.mapAttrs (name: _: "${source}/${name}") filtered;

  forAllSystems = lib.genAttrs [
      "x86_64-linux" 
      "aarch64-linux" 
      "x86_64-darwin" 
      "aarch64-darwin"
  ];

  scanDirs = path:
  let
    entries = builtins.readDir path;
    dirs = lib.filterAttrs (name: type: type == "directory") entries;
  in
    lib.mapAttrsToList (name: _: path + "/${name}") dirs;
}
