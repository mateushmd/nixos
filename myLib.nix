pkgs:
let
  inherit (pkgs) lib;
in
{
  fetchWallpapers = { owner, repo, rev }: 
  let
    source = fetchGit {
      url = "git@github.com:${owner}/${repo}.git";
      inherit rev;
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


  scanDirs = path:
  let
    entries = builtins.readDir path;
    dirs = lib.filterAttrs (name: type: type == "directory") entries;
  in
    lib.mapAttrsToList (name: _: path + "/${name}") dirs;
}
