{ hostname, user, pkgs, ... }:

{
  imports = 
    (import ./shell) ++
    [(import ./hosts/${hostname})];

  users.users.${user} = {
    isNormalUser = true;

    initialPassword = "password";

    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "video" "audio" "camera" 
    ];
  };

  # Boot
  boot = {
    tmp = {
      cleanOnBoot = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  # System
  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
    };
  };

  # Packages
  environment.systemPackages = with pkgs; [
      # Commons
      htop
      wget
      # System
      brightnessctl
      playerctl
  ];

  # Nix
  nix = {

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
  };

  # Networking
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # OpenGL
  hardware.opengl = {
    enable = true;
  };

  # Audio
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    jack.enable = true;
    pulse.enable = true;
  };

  # Security
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}
