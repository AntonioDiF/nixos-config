# Configuration file for Alacritty

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.alacritty;
in
{
  options.alacritty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `alacritty`";
      relatedPackages = [ "alacritty" ];
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = lib.mkForce 0.85;
      };
    };
  };
}
