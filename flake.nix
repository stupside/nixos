{
  description = "Home Manager configuration of Xonery";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      user = "Xonery";
    in {

    nixosConfigurations = (
      import ./src {
        inherit user;
	      inherit nixpkgs;
      }
    )
}
