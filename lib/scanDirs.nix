{ lib }:
path:
  let
    entries = builtins.readDir path;

    dirs = lib.filterAttrs (name: type: type == "directory") entries;
  in
    lib.mapAttrsToList (name: _: path + "/${name}") dirs
