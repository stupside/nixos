{ pkgs, user, ... }:

{ 
  imports =
    (import ./modules/programs) ++
    (import ./modules/services);

  home = {

    username = "${user}";
    homeDirectory = "/home/${user}";
    
    stateVersion = "22.11";

    packages = with pkgs; [
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = "JetBrains Mono Medium";
    };
  };
}
