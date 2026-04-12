{ config, ... }:
{
  networking = {
    # Enable networking
    networkmanager.enable = true;
    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;
    # Open ports in the firewall.
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        8000
        8001
        config.services.portainer.port
      ];
      # allowedUDPPorts = [ ... ];
    };
    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };
}
