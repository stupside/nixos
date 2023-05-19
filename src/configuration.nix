# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, user, ... }:

{  
  imports = (import ./shell);

  # User
  users = {
    users.${user} = {
      isNormalUser = true;

      initialPassword = "password";

      extraGroups = [ "wheel" "networkmanager" "video" "audio" "camera" ];
    };

    defaultUserShell = pkgs.fish;
  };

  # System
  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
    };
  };

  # Nix
  nix = {

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  # i18
  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  console.keyMap = "fr";

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  # Security
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Services
  services = {

    flatpak.enable = true;
    
    printing.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      jack.enable = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;

      libinput.enable = true;

      layout = "fr";
      xkbVariant = "";

      displayManager = {
        lightdm.enable = true;
        defaultSession = "gnome";
      };

      desktopManager = {
        gnome.enable = true;
      };
    };
  };

  # Envrionment
  environment = {

    variables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
        # commons
        htop
        wget
        # editors
        vim
        # system
        brightnessctl
    ];
  
    shells = with pkgs; [ fish ];
  };
}
