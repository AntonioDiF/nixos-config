# Configuration file that enables a chromium-based browser and sets it as default

{ config, lib, pkgs, ... }:

let
  cfg = config.chromium;
in
{
  options.chromium = {
    enable
      = lib.mkEnableOption "enable chromium-based browser";

    package = lib.mkOption {
      default = "chromium";
      description = ''
        browser package name
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.${cfg.package};
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
      ];
      commandLineArgs = [
        "--disable-features-WebRtcAllowInputVolumeAdjustment"
      ];
    };
  };
}
