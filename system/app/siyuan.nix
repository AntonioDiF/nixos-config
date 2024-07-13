# Configuration file that sets up the Discord client

{ config, lib, pkgs, ... }:

let
  cfg = config.siyuan;
in
{
  options.siyuan = {
    enable
      = lib.mkEnableOption "enable siyuan"; 
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "siyuan"
      ];
    environment.systemPackages = [
      pkgs.siyuan
    ];
  };
}
