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
      globals = {
        mapleader = "<Space>";
      };
      options = {
        number = true;
        # relativenumber = true;
        wildmode = "longest,list";
        # cc = 88;
        smartindent = true;
        tabstop = 2;
	      expandtab = true;
        shiftwidth = 2;
        softtabstop = 2;
      };
      extraPlugins = [
      	pkgs.vimExtraPlugins.nvim-web-devicons
      ];
      plugins = {
        # Autocompletion
        nvim-cmp = {
          enable = true;
          snippet.luasnip.enable = true;
          mappingPresets = [ "insert" "cmdline" ];
        };
	      # coq = {
	        # enable = true;
	        # autoStart = true; 
	        # installArtifacts = true;
	      # };
	      # # Dashboard
	      # dashboard = {
	        # enable = true;
	      # };
	      # Language Server Provider
        lspconfig = {
          enable = true;
          servers = {
            lua-language-server.enable = true;
            nil.enable = true;
          };
        };
	      # # Several plugins
	      # mini = {
	        # enable = true;
	        # # Keep sessions
	        # sessions = {
	          # enable = true;
	          # extraConfig = {
	            # autoread = true;
	          # };
	        # };
	      # };
	      # # File explorer
	      # nvim-tree = {
	        # enable = true;
	      # };
	      # # Find files
	      # telescope = {
	        # enable = true;
	      # };
	      # Parser generator tool. Improves highlight and might be prerequisite for LSPs 
        treesitter = {
          enable = true;
          indent = true;
        };
      };
    };
  };
}
