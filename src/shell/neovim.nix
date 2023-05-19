{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    configure = {

      packages.myVimPackages = with pkgs.vimPlugins; {
        start = [
            vim-nix
        ];
      };
    };
  };
}