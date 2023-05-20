{
  description = "Home Manager configuration of Xonery";

  inputs = {
    # Packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Flakes
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = { nixpkgs, /* Flakes */ home-manager, hyprland, ... } @inputs :
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { 
        inherit system;

        config = {
          allowUnfree = true;
        };
      };

      make = hostname: user:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = { inherit inputs; inherit pkgs hostname user; };

          modules = [
            # System
            ./system

            # Flakes
            home-manager.nixosModules.default

            # Home
            home-manager.nixosModules.home-manager {
            
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = { inherit inputs; inherit pkgs hostname user; };
                
                users.${user} = 
                {
                  imports = [
                    ./home
                    hyprland.homeManagerModules.default
                    {wayland.windowManager.hyprland.enable = true;}
                  ];
                };
              };
            }
          ];
        };

    in {

      nixosConfigurations = {

        # Desktop profile
        desktop = make "desktop" "xonery";
      };
    };
}