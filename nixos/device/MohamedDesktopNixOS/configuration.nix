{ pkgs, pkgsStable, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  # Define your hostname.
  networking.hostName = "MohamedDesktopNixOS";
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = [ pkgsStable.hplipWithPlugin ];
  };
  # Enable SANE scanning support.
  hardware.sane = {
    enable = false;
    extraBackends = [ pkgsStable.hplipWithPlugin ];
    openFirewall = true;
    backends-package = pkgsStable.sane-backends;
  };
  environment.systemPackages =
    (with pkgs; [
      ddcui
      ddcutil
    ])
    ++ (with pkgsStable; [
      xsane
      sane-backends
      sane-frontends
    ]);
  nixpkgs.config.cudaCapabilities = [ "8.0" ];
}
