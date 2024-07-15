# Configuration file that sets up the GNOME Desktop Environment.

{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.gnome;
in
{
  imports = [
    ./w11.nix
  ];

  options.gnome = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `gnome`";
      relatedPackages = [ "gnome" ];
    };
  };

  config = mkIf cfg.enable {
    # Enable xserver
    x11.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
