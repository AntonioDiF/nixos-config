# Configuration file that sets up Python 3

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkIf types;

  cfg = config.python;
in
{
  options.python = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable `python`";
      relatedPackages = [ "python3" ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.python3
    ];
  };
}
