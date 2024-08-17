# Configuration file that sets up Hyprland

{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.hyprland;
in
{
  imports = [
    ./wayland.nix
  ];

  options.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `hyprland`";
      relatedPackages = [ "hyprland" ];
    };
  };

  config = mkIf cfg.enable {
    # Enable wayland
    wayland.enable = true;

    # Adding hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
