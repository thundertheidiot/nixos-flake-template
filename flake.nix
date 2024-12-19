{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = let
      mkSystem = hostCfg:
        nixpkgs.lib.nixosSystem rec {
          specialArgs = {inherit inputs;};
          modules = [
            hostCfg.system # Host specific NixOS configuration
            # NixOS Modules
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            # Your NixOS configuration defined in ./modules/nixos
            ./modules/nixos # ./directory == ./directory/default.nix

            ({...}: {
              nixpkgs = {
                config.allowUnfree = true;
                overlays = [
                ];
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;

                sharedModules = [
                  # Home Manager modules
                ];

                users."user" = {config, ...}: {
                  # Note, inside this attrset config refers to the home-manager config variable, not the global nixos one
                  home = {
                    username = "user";
                    homeDirectory = "/home/${config.home.username}";
                  };

                  imports = [
                    hostCfg.home # Host specific Home Manager configuration
                    # Your Home Manager configuration defined in ./modules/home
                    ./modules/home
                  ];
                };
              };
            })
          ];
        };
    in {
      hostname = mkSystem (import ./hosts/hostname);
    };
  };
}
