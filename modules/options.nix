{ lib, ... }: {
  options.flake.homeManagerModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = { };
  };
}
