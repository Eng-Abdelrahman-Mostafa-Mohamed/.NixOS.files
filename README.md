# MH0386's NixOS Configuration

[![CI](https://github.com/MH0386/.dotfiles.nix/actions/workflows/ci.yaml/badge.svg)](https://github.com/MH0386/.dotfiles.nix/actions/workflows/ci.yaml)

## Steps

- Add the following to your `/etc/nixos/configuration.nix` file:

  ```nix
  programs.nh = {
    enable = true;
    flake = "/home/mohamed/.dotfiles";
    clean = {
        enable = true;
        extraArgs = "--keep 5";
    };
  };
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  # Make sure to change the hostname
  networking.hostName = "MohamedLaptopNixOS"; # or "MohamedDesktopNixOS";
  ```

- Switch to the new configuration:

  ```bash
  nixos-rebuild switch
  ```

- Download the dotfiles repository:

  ```bash
  nix-shell -p git
  git clone https://github.com/MH0386/.dotfiles.nix.git ~/.dotfiles
  ```

- Switch to apply the dotfiles:

  ```bash
  nixos-rebuild switch --flake ~/.dotfiles#nixos
  ```
