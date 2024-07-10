# Configuration file that sets up tmux

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types optionalString;

  cfg = config.tmux;
in
{
  options.tmux = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `tmux`";
      relatedPackages = [ "tmux" ];
    };
    colors = mkOption {
      type = types.attrs;
      default = {
        accent = "darkblue";
        dimAccent = "blue";
        accentForeground = "white";
        background = "cyan";
        foreground = "black";
        dimForeground = "darkgray";
      };
      description = "tmux colors";
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      mouse = true;
      keyMode = "vi";
      shortcut = "a";
      escapeTime = 0;
      historyLimit = 50000;
      aggressiveResize = true;
      terminal = "tmux-256color";
      extraConfig = ''
        # Bindings

        ## Reload tmux config
        bind C-r source ~/.config/tmux/tmux.conf; display "Sourced ~/.config/tmux/tmux.conf"

        # Misc

        ## Focus events enabled for terminals that support them
        set -g focus-events on

        # Style
      
        ## Counting
        set -g base-index 1
        setw -g pane-base-index 1
        
        ## Titles
        set -g set-titles on
      
        ## Timing
      
        ### Update status bar every second instead of every 15. Likely uses more energy
        set -g status-interval 1
        ### Display panes for 3 seconds instead of 1
        set -g display-panes-time 3000

        ## Status bar
        set -g status-left-length 25
        set -g status-right ' "#{=21:pane_title}" %H:%M:%S %d-%b-%y'
      
        ## Colors
        set -g status-style 'fg=${cfg.colors.foreground}, bg=${cfg.colors.background}'

        set -g window-status-current-style 'fg=${cfg.colors.accentForeground} bg=${cfg.colors.accent}'

        set -g pane-border-style 'fg=${cfg.colors.background}'
        set -g pane-active-border-style 'fg=${cfg.colors.dimAccent}'
  
        set -g message-style 'fg=${cfg.colors.accentForeground}, bg=${cfg.colors.accent}'
  
        set -g mode-style 'fg=${cfg.colors.background}, bg=${cfg.colors.accent}'
  
        set -g display-panes-active-colour '${cfg.colors.accent}'
        set -g display-panes-colour '${cfg.colors.dimForeground}'
  
        set -g clock-mode-colour '${cfg.colors.accent}'
      '';
    };
  };
}
