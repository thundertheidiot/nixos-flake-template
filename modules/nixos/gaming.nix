{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.mynixos.gaming.enable {
    programs.steam = {
      enable = true;
    };

    programs.gamescope.enable = true;
  };
}
