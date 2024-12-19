{pkgs, ...}: {
  imports = [
    ./gaming.nix
  ];

  config = {
    # Your nixos configuration
    users.users."user" = {
      extraGroups = ["wheel" "networkmanager"];
      isNormalUser = true;
    };

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      allowed-users = ["user"];
      trusted-users = ["user"];
      use-xdg-base-directories = true;
    };

    networking.networkmanager.enable = true;

    i18n.defaultLocale = "en_US.UTF-8";

    environment.systemPackages = with pkgs; [
      git
    ];
  };
}
