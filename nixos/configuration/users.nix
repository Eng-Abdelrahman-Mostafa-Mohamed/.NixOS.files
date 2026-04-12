{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mohamed = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Mohamed Hisham";
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
