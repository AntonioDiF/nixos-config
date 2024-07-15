# Configuration file that sets up the X11 windowing system

{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.x11;
in
{
  options.x11 = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `x11`";
    };

    keyboardLayout = mkOption {
      type = types.str;
      default = "us";
      description = "X11 keyboard layout";
    };

    keyboardVariant = mkOption {
      type = types.str;
      default = "";
      description = "X11 keyboard variant";
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = cfg.keyboardLayout;
        variant = cfg.keyboardVariant;
      };
    }; 
  };
}
