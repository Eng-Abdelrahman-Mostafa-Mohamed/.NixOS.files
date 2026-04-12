{
  description = "Abdelrahman's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    # nix-software-center = {
    #   url = "github:ljubitje/nix-software-center";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nixos-conf-editor = {
    #   url = "github:snowfallorg/nixos-conf-editor";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    portainer-on-nixos = {
      url = "gitlab:cbleslie/portainer-on-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-jetbrains-plugins = {
      url = "github:nix-community/nix-jetbrains-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oh-my-bash = {
      url = "github:ohmybash/oh-my-bash";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nix-flatpak,
      home-manager,
      nur,
      lanzaboote,
      portainer-on-nixos,
      nix-jetbrains-plugins,
      niri,
      dms,
      dms-plugin-registry,
      oh-my-bash,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      inherit (nixpkgs) lib;
      pkgsStable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      hostNames = [
        "Abdelrahman-nixos"
      ];
      commonModules = [
        home-manager.nixosModules.home-manager
        nur.modules.nixos.default
        lanzaboote.nixosModules.lanzaboote
        portainer-on-nixos.nixosModules.portainer
        ./nixos/configuration.nix
      ];
    in
    {
      nixosConfigurations = lib.pipe hostNames [
        (map (
          hostName:
          lib.nameValuePair hostName (
            lib.nixosSystem {
              inherit system;
              modules =
                commonModules
                ++ [ { networking.hostName = hostName; } ] # Sets the hostname
                ++ [ (./. + "/nixos/device/${hostName}/configuration.nix") ]; # Imports the per-host configuration.nix
              specialArgs = {
                inherit inputs;
                inherit system;
                inherit nix-flatpak;
                inherit pkgsStable;
                inherit nur;
                inherit nix-jetbrains-plugins;
                inherit niri;
                inherit dms;
                inherit dms-plugin-registry;
                inherit oh-my-bash;
              };
            }
          )
        ))
        lib.listToAttrs
      ];
    };
}
