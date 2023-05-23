{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Gnome
  services.xserver = {
    enable = true;
    
    displayManager.gdm.enable = true;

    desktopManager = {
      gnome.enable = true;
      xterm.enable = false;
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    baobab            # disk usage analyzer
    epiphany          # web browser
    simple-scan       # document scanner
    yelp              # help viewer
    evince            # document viewer
    # seahorse        # password manager

    gnome.file-roller # archive manager
    gnome.geary       # email client
    gnome.totem       # video player
    gnome.gedit       # text editor
    gnome.cheese      # photo booth
    gnome.eog         # image viewer

    # gnome-calculator 
    # gnome-calendar 
    gnome.gnome-characters 
    gnome.gnome-clocks 
    gnome.gnome-contacts
    gnome.gnome-font-viewer
    gnome.gnome-maps 
    gnome.gnome-music
    gnome.gnome-system-monitor
    gnome.gnome-weather
    gnome.gnome-disk-utility
    
    gnome-tour
    # gnome-logs 
    gnome-photos 
    # gnome-screenshot    
    # gnome-connections
  ];

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
  ];

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