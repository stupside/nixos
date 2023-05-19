{ nixpkgs, home-manager, user, ... }: 

let
  system = "x86_64-linux";

  pkgs = import nixpkgs { 
    inherit system;

    config.allowUnfree = true;
  };
in 
{

  hostname = nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = { inherit pkgs user; };

    modules = [
      ./configuration
      ./configuration.nix
      home-manager.nixosModules.home-manager {
      
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = 
        {
          inherit user pkgs;
        };
        
        home-manager.users.${user} = 
        {
          imports = [
            ./home.nix
          ];
        };
      }
    ];
  };

}
