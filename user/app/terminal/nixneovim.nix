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
      colorschemes = {
        catppuccin = {
          enable = true;
          termColors = true;
          dimInactive.enabled = true;
        };
      };
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      globals = {
        mapleader = " ";
        maplocalleader = " ";
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
      mappings = {
        normalVisualOp = {
          ";" = "':'"; # vimscript between ' '
        };
        normal = {
          # Telescope
          "<leader>ff" = "require('telescope.builtin').find_files";
          "<leader>fg" = "require('telescope.builtin').live_grep";
          "<leader>fc" = "require('telescope.builtin').treesitter";
          "<leader>fb" = "require('telescope.builtin').buffers";
          "<leader>fh" = "require('telescope.builtin').help_tags";
        };
      };
      extraPlugins = with pkgs.vimExtraPlugins; [
        {
          plugin = nvim-web-devicons;
          optional = false;
        }
      ];
      plugins = {
        # Autocompletion
        # nvim-cmp = {
          # enable = true;
          # snippet.luasnip.enable = true;
          # mappingPresets = [ "insert" "cmdline" ];
        # };
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
        # File explorer
        nvim-tree = {
          enable = true;
          disableNetrw = true;
          openOnTab = true;
          git = {
            enable = true;
          };
        };
        # Find files
        telescope = {
          enable = true;
        };
        # Parser generator tool. Improves highlight and might be prerequisite for LSPs
        treesitter = {
          enable = true;
          indent = true;
        };
        # Show context for current code line (classes, function) when out of the screen
        treesitter-context = {
          enable = true;
        };
      };
    };
  };
}
