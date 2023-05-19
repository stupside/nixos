{ pkgs, ... }:

{
  # Boot
  boot = {
    loader = {
      grub = {
        enable = true;
	      device = "/dev/vda";
      };
    };
  };

  # Networking
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  hardware = {

    # OpenGL
    opengl = {
      enable = true;
    };

    # Bluetooth
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
  
  # Bluetooth
  services.blueman.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = { 
      enable = true; 
      setSocketVariable = true;
    };
  };

  envrionnement.systemPackages = with pkgs; [
    docker-compose
  ];
}
