{
  pkgs,
  nur,
  pkgsStable,
  nix-flatpak,
  nix-jetbrains-plugins,
  niri,
  dms,
  dms-plugin-registry,
  inputs,
  ...
}:
let
  timestamp = pkgs.lib.readFile "${pkgs.runCommand "timestamp" { }
    "echo -n `date '+%Y%m%d%H%M%S'` > $out"
  }";
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.abdelrahman = import ./../home-manager/hm-configuration.nix;
    extraSpecialArgs = {
      inherit inputs;
      inherit nur;
      inherit pkgsStable;
      inherit nix-flatpak;
      inherit nix-jetbrains-plugins;
      inherit niri;
      inherit dms;
      inherit dms-plugin-registry;
    };
    backupFileExtension = "backup-${timestamp}";
    verbose = true;
  };
}
