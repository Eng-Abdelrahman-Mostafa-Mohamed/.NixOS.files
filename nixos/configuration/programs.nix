_: {
  programs = {
    niri.enable = true;
    xonsh = {
      enable = true;
      config = "execx($(atuin init xonsh))";
    };
    zsh.enable = true;
    fish.enable = true;
    nix-index.enable = true;
    # evolution.enable = true;
    nix-ld.enable = true;
    virt-manager.enable = true;
    localsend.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    # coolercontrol.enable = true;
    nh = {
      enable = true;
      flake = "/home/mohamed/.dotfiles";
      clean = {
        enable = true;
        extraArgs = "--keep 5";
      };
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "ghostty";
    };
    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    # programs.mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    seahorse.enable = true;
  };
}
