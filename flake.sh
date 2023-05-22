cp /etc/nixos/hardware-configuration.nix ./system/hosts/desktop

sudo nixos-rebuild switch --flake .#hostname