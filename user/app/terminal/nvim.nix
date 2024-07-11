# Configuration file that sets up nvim

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.nvim;
in
{
  options.nvim = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `nvim`";
      relatedPackages = [ "neovim" ];
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        set number relativenumber   " add line numbers showing relative next lines
        set wildmode=longest,list   " get bash-like tab completions
        set cc=88                   " mark columns that exceed 88 chars for good coding style
        filetype plugin indent on   " allows auto-indenting depending on file type
        set tabstop=2               " number of columns occupied by a tab character
        set expandtab               " convert tabs to white space
        set shiftwidth=2            " width for autoindents
        set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
      '';
    };
  };
}
