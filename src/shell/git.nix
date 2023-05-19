{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    userName = "xonery";
    userEmail = "kilian.houpeurt@gmail.com";
    
    extraConfig = {
      commit.verbose = true;
      
      init.defaultBranch = "master";
      pull.rebase = "true";
    };
  };
}
