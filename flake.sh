cp /etc/nixos/hardware-configuration.nix ./home/hosts/desktop

sudo nixos-rebuild switch --flake .#hostname