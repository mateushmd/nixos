pkgs:
let
  inherit (pkgs) lib;
in
{
  scanDirs = path:
  let
    entries = builtins.readDir path;
    dirs = lib.filterAttrs (name: type: type == "directory") entries;
  in
    lib.mapAttrsToList (name: _: path + "/${name}") dirs;

  scanFiles = path:
  let
    entries = builtins.readDir path;
    files = lib.filterAttrs (_: type: type == "regular") entries;
  in
    lib.mapAttrsToList (name: _: path + "/${name}") files;
}
