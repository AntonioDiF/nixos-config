{ config, pkgs, ... }:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
in
{
  # bash configuration
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  # zsh configuration
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}
