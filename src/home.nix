{ pkgs, user, ... }:

{ 
  imports =
    (import ../modules/programs) ++
    (import ../modules/services);

  home = {

    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
        font = {
            name = "JetBrains Mono Medium";
        };
    };
  }
}