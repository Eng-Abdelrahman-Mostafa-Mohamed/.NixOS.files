{ pkgs, ... }:
{
  # Enable common container config files in /etc/containers
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
    containers.enable = true;
    podman = {
      enable = true;
    };
    docker = {
      enable = true;
      rootless = {
        enable = true;
      };
    };
  };
}
