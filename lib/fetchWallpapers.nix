{ pkgs }: 
{ 
  owner,
  repo,
  rev,
  hash
}: 
  let
    inherit (pkgs) lib;

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
    lib.mapAttrs (name: _: "${source}/${name}") filtered
