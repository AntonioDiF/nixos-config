# Configuration file that sets up the Discord client

{ config, home, lib, pkgs, ... }:

let
  cfg = config.discord;
in
{
  options.discord = {
    enable
      = lib.mkEnableOption "enable discord";
    useVencord
      = lib.mkEnableOption "use vencord";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "discord"
      ];
    home.packages = [
      (pkgs.discord.override {
        withVencord = cfg.useVencord;
      })
    ];
  };
}
