_: {
  enable = true;
  enableBashIntegration = true;
  enableFishIntegration = true;
  enableZshIntegration = true;
  installBatSyntax = true;
  settings = {
    theme = "GitHub Dark";
    font-size = 12;
    font-family-bold = "JetBrains Mono Bold";
    font-family = "JetBrains Mono";
    font-feature = "liga";
    window-decoration = "auto";
    window-padding-x = 12;
    window-padding-y = 12;
    window-padding-balance = true;
    background-opacity = 1.0;
    background-blur-radius = 32;
    window-save-state = "always";
    cursor-style = "block";
    cursor-style-blink = true;
    mouse-hide-while-typing = true;
    copy-on-select = true;
    confirm-close-surface = false;
    focus-follows-mouse = true;
    keybind = [
      "ctrl+c=copy_to_clipboard"
      "ctrl+v=paste_from_clipboard"
      "ctrl+shift+n=new_window"
      "ctrl+t=new_tab"
      "ctrl+plus=increase_font_size:1"
      "ctrl+minus=decrease_font_size:1"
      "ctrl+zero=reset_font_size"
      "shift+enter=text:\n"
    ];
    unfocused-split-opacity = 0.7;
    unfocused-split-fill = "#44464f";
    adw-toolbar-style = "flat";
    gtk-titlebar = true;
    shell-integration = "detect";
    shell-integration-features = "cursor,sudo,title,no-cursor";
    gtk-single-instance = true;
    # config-file = "./config-dankcolors";
  };
}
