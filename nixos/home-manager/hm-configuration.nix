{ inputs, ... }:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.modules.default
    ./hm-configuration/dconf.nix
    ./hm-configuration/gtk.nix
    ./hm-configuration/home.nix
    ./hm-configuration/programs.nix
    ./hm-configuration/services.nix
    ./hm-configuration/xdg.nix
  ];
}
