{ pkgs }:
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

  removeAttrsRec = attrSet: attrs:
  let
    parsedPaths = builtins.map (lib.splitString ".") attrs;

    removePath = path: set:
      if path == [] || !builtins.isAttrs set then 
        set
      else
        let
          head = builtins.head path;
          tail = builtins.tail path;
        in
          if tail == [] then
            builtins.removeAttrs set [ head ]
          else if builtins.hasAttr head set then
            set // { ${head} = removePath tail set.${head}; }
          else
            set;
  in
  builtins.foldl' (acc: path: removePath path acc) attrSet parsedPaths;
}
