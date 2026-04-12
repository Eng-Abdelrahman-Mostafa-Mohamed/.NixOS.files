_: {
  services = {
    iio-niri.enable = true;
    vnstat.enable = true;
    pulseaudio.enable = false;
    avahi = {
      enable = true;
      publish.enable = true;
    };
    flatpak.enable = true;
    fwupd.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    # displayManager = {
    #   sddm = {
    #     enable = true;
    #    wayland.enable = true;
    #  };
    # };
    # desktopManager.plasma6.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Configure keymap in X11
      xkb.layout = "us";
      # Load nvidia driver for Xorg and Wayland
      videoDrivers = [ "nvidia" ];
    };
    # Enable the COSMIC Desktop Environment.
    # desktopManager.cosmic.enable = true;
    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    displayManager.dms-greeter = {
      enable = false;
      compositor.name = "niri"; # Or "hyprland" or "sway"

      # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
      configHome = "/home/mohamed";

      # Save the logs to a file
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    gnome = {
      sushi.enable = true;
      gnome-user-share.enable = true;
      gnome-keyring.enable = true;
      gnome-software.enable = true;
      gnome-online-accounts.enable = true;
      gnome-settings-daemon.enable = true;
    };
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        public = {
          browseable = "yes";
          comment = "Public samba share.";
          writable = "yes";
          "guest ok" = "yes";
        };
      };
    };
    portainer = {
      # Default false
      enable = true;
      # Default latest, you can check dockerhub for other tags.
      version = "latest";
      # Default false, set to 'true' if you want to be able to access via the port on something other than localhost.
      openFirewall = true;
      # Sets the port number in both the firewall and the docker container port mapping itself.
      port = 9443;
    };
  };
}
