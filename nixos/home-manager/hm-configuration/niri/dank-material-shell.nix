_: {
  enable = true;

  niri = {
    enableSpawn = true; # Auto-start DMS with niri, if enabled

    includes.filesToInclude = [
      # Files under `$XDG_CONFIG_HOME/niri/dms` to be included into the new config
      "alttab" # Please note that niri will throw an error if any of these files are missing.
      "binds"
      "colors"
      "layout"
      "outputs"
    ];
  };

  # Core features
  enableSystemMonitoring = true; # System monitoring widgets (dgop)
  enableVPN = true; # VPN management widget
  enableDynamicTheming = true; # Wallpaper-based theming (matugen)
  enableAudioWavelength = true; # Audio visualizer (cava)
  enableCalendarEvents = false; # Calendar integration (khal)
  enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

  settings = {
    theme = "dark";
    dynamicTheming = true;
    use24HourClock = false;
    currentThemeName = "dynamic";
    animationSpeed = 2;
    appLauncherGridColumns = 4;
    appLauncherViewMode = "list";
    appPickerViewMode = "grid";
    appsDockActiveColorMode = "primary";
    appsDockColorizeActive = false;
    appsDockEnlargeOnHover = true;
    appsDockEnlargePercentage = 125;
    appsDockHideIndicators = false;
    appsDockIconSizePercentage = 100;
    audioVisualizerEnabled = true;
    audioWheelScrollAmount = 5;
    launcherLogoMode = "os";
    desktopClockEnabled = true;
    desktopClockHeight = 180;
    desktopClockShowAnalogNumbers = false;
    desktopClockShowAnalogSeconds = true;
    desktopClockShowDate = true;
    desktopClockStyle = "analog";
    enableFprint = true;
    gtkThemingEnabled = true;
    iconTheme = "System Default";
    lockScreenShowDate = true;
    lockScreenShowMediaPlayer = true;
    lockScreenShowPasswordField = true;
    lockScreenShowPowerActions = true;
    lockScreenShowProfileImage = true;
    lockScreenShowSystemIcons = true;
    lockScreenShowTime = true;
    loginctlLockIntegration = true;
    matugenScheme = "scheme-tonal-spot";
    matugenTemplateAlacritty = true;
    matugenTemplateDgop = true;
    matugenTemplateEmacs = true;
    matugenTemplateEquibop = true;
    matugenTemplateFirefox = true;
    matugenTemplateFoot = true;
    matugenTemplateGhostty = true;
    matugenTemplateGtk = true;
    matugenTemplateHyprland = true;
    matugenTemplateKcolorscheme = true;
    matugenTemplateKitty = true;
    matugenTemplateMangowc = true;
    matugenTemplateNeovim = true;
    matugenTemplateNiri = true;
    matugenTemplatePywalfox = true;
    matugenTemplateQt5ct = true;
    matugenTemplateQt6ct = true;
    matugenTemplateVesktop = true;
    matugenTemplateVscode = true;
    matugenTemplateWezterm = true;
    matugenTemplateZenBrowser = true;
    modalDarkenBackground = true;
    networkPreference = "auto";
    niriOutputSettings = {
      eDP-1 = {
        vrrOnDemand = true;
      };
    };
    notificationHistoryEnabled = true;
    notificationHistorySaveCritical = true;
    notificationHistorySaveLow = true;
    notificationHistorySaveNormal = true;
    osdAudioOutputEnabled = true;
    osdBrightnessEnabled = true;
    osdCapsLockEnabled = true;
    osdIdleInhibitorEnabled = true;
    osdMediaPlaybackEnabled = true;
    osdMediaVolumeEnabled = true;
    osdMicMuteEnabled = true;
    osdVolumeEnabled = true;
    showBattery = true;
    showCapsLockIndicator = true;
    showClipboard = true;
    showClock = true;
    showControlCenterButton = true;
    showCpuTemp = true;
    showCpuUsage = true;
    showDock = true;
    showFocusedWindow = true;
    showGpuTemp = true;
    showLauncherButton = true;
    showMemUsage = true;
    showMusic = true;
    showNotificationButton = true;
    showPrivacyButton = true;
    showSeconds = false;
    showSystemTray = true;
    showWeather = true;
    showWorkspaceApps = true;
    showWorkspaceSwitcher = true;
    soundNewNotification = true;
    soundPluggedIn = true;
    soundsEnabled = true;
    soundVolumeChanged = true;
    systemMonitorEnabled = true;
    systemMonitorShowCpu = true;
    systemMonitorShowCpuGraph = true;
    systemMonitorShowCpuTemp = true;
    systemMonitorShowDisk = true;
    systemMonitorShowGpuTemp = true;
    systemMonitorShowHeader = true;
    systemMonitorShowMemory = true;
    systemMonitorShowMemoryGraph = true;
    systemMonitorShowNetwork = true;
    systemMonitorShowNetworkGraph = true;
    systemMonitorShowTopProcesses = true;
    useAutoLocation = true;
    useSystemSoundTheme = true;
    wallpaperFillMode = "Fill";
    waveProgressEnabled = true;
    weatherEnabled = true;
    privacyShowCameraIcon = true;
    privacyShowMicIcon = true;
    privacyShowScreenShareIcon = true;
    powerActionConfirm = true;
    powerActionHoldDuration = 0.5;
    powerMenuActions = [
      "reboot"
      "logout"
      "poweroff"
      "lock"
      "suspend"
      "restart"
    ];
    powerMenuDefaultAction = "suspend";
    runDmsMatugenTemplates = true;
    dockLauncherEnabled = true;
    dankLauncherV2BorderColor = "primary";
    dankLauncherV2ShowFooter = true;
    dankLauncherV2UnloadOnClose = false;
    controlCenterShowAudioIcon = true;
    controlCenterShowAudioPercent = false;
    controlCenterShowBatteryIcon = false;
    controlCenterShowBluetoothIcon = true;
    controlCenterShowBrightnessIcon = false;
    controlCenterShowBrightnessPercent = false;
    controlCenterShowMicIcon = false;
    controlCenterShowMicPercent = false;
    controlCenterShowNetworkIcon = true;
    controlCenterShowPrinterIcon = true;
    controlCenterShowScreenSharingIcon = true;
    controlCenterShowVpnIcon = true;
    controlCenterTileColorMode = "primary";
    controlCenterWidgets =
      map
        (id: {
          enabled = true;
          inherit id;
          width = 50;
        })
        [
          "volumeSlider"
          "brightnessSlider"
          "wifi"
          "bluetooth"
          "audioOutput"
          "audioInput"
          "nightMode"
          "darkMode"
        ];
    cornerRadius = 12;
    barConfigs = [
      {
        autoHide = false;
        autoHideDelay = 250;
        borderColor = "surfaceText";
        borderEnabled = false;
        borderOpacity = 1;
        borderThickness = 1;
        bottomGap = 0;
        centerWidgets = [
          "music"
          "clock"
          "weather"
        ];
        clickThrough = false;
        enabled = true;
        fontScale = 1;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        gothCornersEnabled = false;
        id = "default";
        innerPadding = 4;
        leftWidgets = [
          "launcherButton"
          "workspaceSwitcher"
          "focusedWindow"
        ];
        name = "Main Bar";
        noBackground = false;
        openOnOverview = false;
        popupGapsAuto = true;
        popupGapsManual = 4;
        position = 0;
        rightWidgets = [
          {
            enabled = true;
            id = "network_speed_monitor";
          }
          {
            enabled = true;
            id = "systemTray";
          }
          {
            enabled = true;
            id = "clipboard";
          }
          {
            enabled = true;
            id = "cpuUsage";
          }
          {
            enabled = true;
            id = "memUsage";
            showSwap = true;
          }
          {
            enabled = true;
            id = "notificationButton";
          }
          {
            enabled = true;
            id = "battery";
          }
          {
            enabled = true;
            id = "controlCenterButton";
            showAudioPercent = false;
            showBatteryIcon = false;
            showBrightnessIcon = false;
            showMicIcon = false;
          }
        ];
        screenPreferences = [
          "all"
        ];
        showOnLastDisplay = true;
        spacing = 4;
        squareCorners = false;
        transparency = 1;
        visible = true;
        widgetOutlineEnabled = false;
        widgetTransparency = 1;
      }
    ];
  };

  session = {
    isLightMode = false;
  };

  clipboardSettings = {
    disabled = false;
    disableHistory = false;
    disablePersist = false;
  };

  # Auto-enabled when plugins have settings configured
  managePluginSettings = true;

  plugins = {
    # Simply enable plugins by their ID (from the registry)
    # dankBatteryAlerts.enable = true;
    dockerManager.enable = true;
    usbManager.enable = true;
    githubNotifier.enable = true;

    # Add plugin-specific settings
    mediaPlayer = {
      enable = true;

      # You can only define settings here if using the home-manager module
      # settings = {
      #   preferredSource = "spotify";
      # };
    };
  };
}
