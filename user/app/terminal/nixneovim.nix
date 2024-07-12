# Configuration file that sets up nixneovim

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.nixneovim;
in
{
  options.nixneovim = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `nixneovim`";
      relatedPackages = [ "nixneovim" ];
    };
  };

  config = mkIf cfg.enable {
    programs.nixneovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      options = {
        number = true;
	expandtab = true;
	smartindent = true;
      };
      # extraConfig = ''
        # set number relativenumber   " add line numbers showing relative next lines
        # set wildmode=longest,list   " get bash-like tab completions
        # set cc=88                   " mark columns that exceed 88 chars for good coding style
        # filetype plugin indent on   " allows auto-indenting depending on file type
        # set tabstop=2               " number of columns occupied by a tab character
        # set expandtab               " convert tabs to white space
        # set shiftwidth=2            " width for autoindents
        # set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
      # '';
      extraPlugins = [
      	pkgs.vimExtraPlugins.nvim-web-devicons
      ];
      plugins = {
        # Autocompletion
	coq = {
	  enable = true;
	  autoStart = true; 
	  installArtifacts = true;
	};
	# Dashboard
	dashboard = {
	  enable = true;
	};
	# Language Server Provider
        lspconfig = {
          enable = true;
          servers = {
	    lua-language-server.enable = true;
            nil.enable = true;
          };
        };
	# Several plugins
	mini = {
	  enable = true;
	  # Keep sessions
	  sessions = {
	    enable = true;
	    extraConfig = {
	      autoread = true;
	    };
	  };
	};
	# File explorer
	nvim-tree = {
	  enable = true;
	};
	# Find files
	telescope = {
	  enable = true;
	};
	# 
        treesitter = {
          enable = true;
          indent = true;
        };
      };
    };
  };
}
