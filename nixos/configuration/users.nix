{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.abdelrahman = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "abdelrahman";
    extraGroups = [
      "adbusers"
      "docker"
      "flatpak"
      "libvirtd"
      "networkmanager"
      "podman"
      "render"
      "video"
      "wheel"
    ];
  };
}
