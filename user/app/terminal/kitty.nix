# Configuration file for Kitty

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.kitty;
in
{
  options.kitty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `kitty`";
      relatedPackages = [ "kitty" ];
    };
    theme = mkOption {
      type = types.str;
      default = "Alabaster Dark";
      description = "`kitty` theme";
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      theme = cfg.theme;
      font = {
        name = "CaskaydiaCove Nerd Font";
        package = pkgs.nerdfonts;
      };
      settings = {
        background_opacity = lib.mkForce "0.85";
        modify_font = "cell_width 105%";
      };
    };
  };
}
