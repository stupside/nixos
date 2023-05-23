{ hostname, user, pkgs, ... }:

{
  imports =
    (import ./modules/programs) ++
    (import ./modules/services) ++
    [(import ./hosts/${hostname})];

  programs.home-manager = {
    enable = true;
  };

  home = {

    username = "${user}";
    homeDirectory = "/home/${user}";
    
    stateVersion = "22.11";

    packages = with pkgs; [
      spotify
      vscode
    ];
  };
}