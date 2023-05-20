{ pkgs, hyprland, ... }:

{
  imports = [(import ./hardware-configuration.nix)]; 

  # Hyperland
  # ++ (hyprland.nixosModules.default)
  # From a VM (WLR_RENDERER_ALLOW_SOFTWARE=1 Hyprland)
  #programs.hyprland.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = { 
      enable = true; 
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    foot
  ];

  environment.variables.TERMINAL = "foot";

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  
  services.blueman.enable = true;

  # i18
  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  console.keyMap = "fr";

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];
}