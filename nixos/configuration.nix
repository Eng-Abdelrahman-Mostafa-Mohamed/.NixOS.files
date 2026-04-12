{ ... }:
{
  imports = [
    ./configuration/boot.nix
    ./configuration/hardware.nix
    ./configuration/locale.nix
    ./configuration/programs.nix
    ./configuration/services.nix
    ./configuration/users.nix
    ./configuration/environment.nix
    ./configuration/home-manager.nix
    ./configuration/networking.nix
    ./configuration/security.nix
    ./configuration/system.nix
    ./configuration/virtualisation.nix
  ];
}
