# Configuration file that sets up the Wayland windowing system

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.wayland;
in
{
  imports = [
    ./x11.nix
  ];
  
  options.wayland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `wayland`";
    };
  };

  config = mkIf cfg.enable {
    # Adding package(s)
    environment.systemPackages = with pkgs; [
      wayland
    ];

    # Enable x11 xserver
    x11.enable = true;

    # Configure xwayland
    services.xserver = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        # theme = "chili";
        package = pkgs.sddm;
      };
    };
  };
}
