_: {
  dconf.settings = {
    "org/gnome/desktop/default-applications".terminal = "ghostty.desktop";
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch Terminal";
      command = "ghostty";
      binding = "<Super>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Launch Vicinae";
      command = "vicinae toggle";
      binding = "<Alt>space";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Launch Clipboard History";
      command = "vicinae deeplink vicinae://extensions/vicinae/clipboard/history";
      binding = "<Super>v";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "vicinae@dagimg-dot"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "gtk4-ding@smedius.gitlab.com"
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "zen.desktop"
        "org.gnome.Nautilus.desktop"
        "com.mitchellh.ghostty.desktop"
        "pycharm.desktop"
        "code.desktop"
        "antigravity.desktop"
        "dev.zed.Zed.desktop"
        "OpenCode.desktop"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = true;
      click-action = "focus-minimize-or-appspread";
      custom-theme-shrink = true;
      dash-max-icon-size = 40;
      dock-position = "BOTTOM";
      extend-height = false;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      scroll-action = "cycle-windows";
      show-mounts-network = true;
      transparency-mode = "DYNAMIC";
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-date = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-blink = true;
      enable-animations = true;
      enable-hot-corners = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
  };
}
