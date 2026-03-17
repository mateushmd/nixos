{ pkgs, utilityFuncs, lib, ... }@args:
let
  dirs = utilityFuncs.scanDirs ./.;
  
  getName = path: builtins.baseNameOf (toString path);

  wrappedModules = builtins.listToAttrs (map (dir: {
    name = getName dir;
    value = (import dir args).apply { inherit pkgs; };
  }) dirs);
in
{
  options.custom.wrapped = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = wrappedModules;
    readOnly = true;
    description = ''
      Attrset of pre-applied wrapped modules. 
      Use `.wrapper` to get the built package, or `.apply { ... }` to customize it further before getting `.wrapper`.
    '';
  };
}
