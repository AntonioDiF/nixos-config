# Configuration file that sets up the Discord client

{ config, home, lib, pkgs, ... }:

let
  cfg = config.vesktop;
in
{
  options.vesktop = {
    enable
      = lib.mkEnableOption "enable vesktop (discord replacement)";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "vesktop"
      ];
    environment.systemPackages = [
      pkgs.vesktop
    ];
  };
}
