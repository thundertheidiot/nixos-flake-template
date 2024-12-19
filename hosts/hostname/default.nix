{
  # NixOS module
  system = {...}: {
    system.stateVersion = "24.11";
    time.timeZone = "Europe/Helsinki";
    networking.hostName = "hostname";

    # Hardware configuration
    # nixos-generate-config

    imports = [
      ./disko.nix
    ];
  };

  # Home Manager module
  home = {...}: {
  };
}
