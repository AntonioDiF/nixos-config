# Configuration file that sets up Steam at the system level

{ config, lib, pkgs, ... }:

let
  cfg = config.steam;
in
{
  options.steam = {
    enable
      = lib.mkEnableOption "enable steam";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
	"steam-original"
	"steam-run"
      ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
