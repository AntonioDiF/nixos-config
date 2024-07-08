# Configuration file that sets up Feral Gamemode at the system level

{ config, lib, pkgs, ... }:

let
  cfg = config.gamemode;
in
{
  options.gamemode = {
    enable
      = lib.mkEnableOption "enable feral gamemode";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode.enable = true;
  };
}
