{
  pkgs,
  pkgsStable,
  config,
  lib,
  inputs,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    niri = import ./niri/niri.nix { inherit pkgs; };
    dank-material-shell = import ./niri/dank-material-shell.nix { inherit pkgs; };
    ghostty = import ./ghostty/ghostty.nix { };
    codex = {
      enable = true;
      enableMcpIntegration = true;
    };
    claude-code = {
      enable = false;
      enableMcpIntegration = true;
      settings = {
        env = {
          ANTHROPIC_API_KEY = "";
          ANTHROPIC_BASE_URL = "https://api.kilo.ai/api/gateway";
        };
      };
    };
    nix-index = {
      # enable = true;
      # enableBashIntegration = true;
      # enableFishIntegration = true;
      # enableNushellIntegration = true;
      # enableZshIntegration = true;
    };
    git = {
      enable = true;
      package = pkgsStable.git;
      settings = {
        user = {
          name = "abdelrahman Hisham Abdelzaher";
          email = "abdelrahman.hisham.abdelzaher@gmail.com";
        };
        pull.rebase = false;
        init.defaultBranch = "main";
        credential = {
          helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
        };
      };
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
        batpipe
        prettybat
      ];
    };
    btop.enable = true;
    command-not-found.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = "${lib.getExe config.programs.fastfetch.package}";
      plugins = [
        {
          name = "fzf";
          inherit (pkgs.fishPlugins.fzf) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
        {
          name = "grc";
          inherit (pkgs.fishPlugins.grc) src;
        }
      ];
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      zsh-abbr.enable = true;
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "andreacasarin/zsh-ask-opencode"; }
        ]
        ++ (map
          (name: {
            name = "plugins/${name}";
            tags = [ "from:oh-my-zsh" ];
          })
          [
            "git"
            "docker"
            "docker-compose"
            "python"
            "pip"
            "node"
            "npm"
            "yarn"
            "rust"
            "sudo"
            "extract"
            "command-not-found"
          ]
        );
      };
      initContent = lib.mkOrder 1500 ''
        ${lib.getExe config.programs.fastfetch.package}

        if [ -f ${config.home.homeDirectory}/.secrets.env ]; then
          source ${config.home.homeDirectory}/.secrets.env
        fi
      '';
    };
    atuin = {
      enable = true;
      daemon.enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        style = "auto";
      };
    };
    zoxide.enable = true;
    bash = {
      enable = true;
      sessionVariables = {
        OSH = "${inputs.oh-my-bash}";
      };
      bashrcExtra = ''
        ${lib.getExe config.programs.fastfetch.package}

        if [ -f ${config.home.homeDirectory}/.secrets.env ]; then
          source ${config.home.homeDirectory}/.secrets.env
        fi

        plugins=(
          git
          cargo
          fzf
          progress
          sudo
          starship
          zoxide
        )

        source ${inputs.oh-my-bash}/oh-my-bash.sh
      '';
    };
    nushell = {
      enable = true;
      plugins = with pkgs.nushellPlugins; [
        gstat
      ];
    };
    pay-respects = {
      enable = true;
    };
    lazydocker.enable = true;
    gh.enable = true;
    ruff = {
      enable = true;
      settings = {
        line-length = 100;
        per-file-ignores = {
          "__init__.py" = [ "F401" ];
        };
        lint = {
          select = [
            "E4"
            "E7"
            "E9"
            "F"
          ];
          ignore = [ ];
        };
      };
    };
    ty = {
      enable = true;
    };
    starship = {
      enable = true;
      settings = {
        format = "$all";
      };
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    topgrade = {
      enable = true;
    };
    yt-dlp = {
      enable = true;
    };
    aria2 = {
      enable = true;
    };
    vscode = {
      enable = true;
      profiles = {
        default = {
          enableMcpIntegration = true;
          # userSettings = {
          #   editor = {
          #     fontSize = 14;
          #     fontFamily = "Fira Code";
          #   };
          # };
          # extensions = with pkgs.vscode-extensions; [ms-python.python ms-python.debugpy njpwerner.autodocstring sourcery.sourcery fill-labs.dependi wakatime.vscode-wakatime usernamehw.errorlens tamasfe.even-better-toml skellock.just redhat.vscode-yaml charliermarsh.ruff];
        };
      };
    };
    lapce.enable = true;
    ssh = {
      enable = true;
    };
    vesktop.enable = true;
    fzf = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    vicinae = {
      enable = true;
      systemd.enable = true;
    };
    eza = {
      enable = true;
      colors = "always";
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      git = true;
      icons = "always";
    };
    carapace = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    gemini-cli = {
      enable = true;
    };
    bun.enable = true;
    opencode = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        plugin = [
          "opencode-wakatime"
          "@mohak34/opencode-notifier"
          "oh-my-openagent"
          "@franlol/opencode-md-table-formatter"
          "@plannotator/opencode"
          "@tarquinen/opencode-dcp"
          "opencode-websearch-cited"
          "opencode-pty"
        ];
      };
    };
    mcp = {
      enable = true;
      servers = {
        nixos = {
          command = "uvx";
          args = [ "mcp-nixos" ];
        };
        github = {
          url = "https://api.githubcopilot.com/mcp";
          headers = {
            Authorization = "{env:GITHUB_PERSONAL_ACCESS_TOKEN}";
          };
        };
        agno = {
          url = "https://docs.agno.com/mcp";
        };
        devenv = {
          command = "devenv";
          args = [
            "mcp"
          ];
        };
        context7 = {
          url = "https://mcp.context7.com/mcp";
          headers = {
            CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
          };
        };
      };
    };
    zed-editor = {
      enable = true;
      userSettings = {
        agent_servers = {
          kilo = {
            type = "registry";
          };
          opencode = {
            type = "registry";
          };
          junie = {
            type = "registry";
          };
          gemini = {
            type = "registry";
          };
          codex-acp = {
            type = "registry";
          };
          claude-acp = {
            type = "registry";
          };
          pi-acp = {
            type = "registry";
          };
          junie-acp = {
            type = "registry";
          };
        };
        ui_font_size = 18.0;
        buffer_font_size = 20.0;
        languages = {
          Nix = {
            formatter = {
              external = {
                command = "nixfmt";
              };
            };
          };
          Python = {
            language_servers = [
              "ty"
              "!basedpyright"
              "..."
            ];
          };
        };
        calls = {
          mute_on_join = true;
        };
        git = {
          inline_blame = {
            show_commit_summary = false;
          };
        };
        terminal = {
          copy_on_select = true;
        };
        git_panel = {
          tree_view = true;
          sort_by_path = true;
        };
        project_panel = {
          hide_hidden = false;
          hide_root = true;
          hide_gitignore = false;
        };
        preview_tabs = {
          enable_preview_from_file_finder = true;
        };
        tabs = {
          show_diagnostics = "errors";
          file_icons = true;
          git_status = true;
        };
        title_bar = {
          show_menus = false;
          show_branch_icon = true;
        };
        prettier = {
          allowed = true;
        };
        colorize_brackets = true;
        inlay_hints = {
          enabled = true;
        };
        always_treat_brackets_as_autoclosed = true;
        toolbar = {
          code_actions = true;
        };
        autosave = {
          after_delay = {
            milliseconds = 1000;
          };
        };
        restore_on_startup = "last_session";
        theme = "GitHub Dark";
        context_servers = {
          arch-ops-server = {
            enabled = false;
            settings = { };
          };
        };
        agent = {
          play_sound_when_agent_done = true;
          default_model = {
            provider = "copilot_chat";
            model = "gpt-5-mini";
          };
          model_parameters = [ ];
        };
      };
      extensions = [
        "arch-mcp"
        "autocorrect"
        "basher"
        "caddyfile"
        "codeowners"
        "colored-zed-icons-theme"
        "csv"
        "desktop"
        "docker-compose"
        "dockerfile"
        "editorconfig"
        "fleet-themes"
        "ghostty"
        "git-firefly"
        "github-actions"
        "github-activity-summarizer"
        "github-dark-default"
        "github-theme"
        "html"
        "ini"
        "jq"
        "json5"
        "jsonl"
        "just"
        "log"
        "markdownlint"
        "mcp-server-brave-search"
        "mcp-server-byterover"
        "mcp-server-context7"
        "mcp-server-github"
        "mcp-server-sequential-thinking"
        "mcp-server-sonarqube"
        "nix"
        "nu"
        "pylsp"
        "pyrefly"
        "pytest-language-server"
        "python-requirements"
        "python-snippets"
        "rainbow-csv"
        "tombi"
        "toml"
        "wakatime"
        "env"
      ];
    };
    uv = {
      enable = true;
    };
    gnome-shell = {
      enable = true;
      extensions = [
        { package = pkgs.gnomeExtensions.dash-to-dock; }
        { package = pkgs.gnomeExtensions.vicinae; }
        { package = pkgs.gnomeExtensions.appindicator; }
        { package = pkgs.gnomeExtensions.caffeine; }
        { package = pkgs.gnomeExtensions.clipboard-indicator; }
        { package = pkgs.gnomeExtensions.gtk4-desktop-icons-ng-ding; }
        { package = pkgs.gnomeExtensions.alphabetical-app-grid; }
        {
          id = "system-monitor@gnome-shell-extensions.gcampax.github.com";
          package = pkgs.gnome-shell-extensions;
        }
      ];
    };
    git-cliff = {
      enable = true;
    };
    jq.enable = true;
    yazi = {
      enable = true;
    };
    obs-studio = {
      enable = true;
      plugins = with pkgsStable.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-backgroundremoval
      ];
    };
    firefox = {
      enable = true;
      package = pkgsStable.firefox;
    };
    firefoxpwa = {
      enable = true;
      package = pkgsStable.firefoxpwa;
    };
  };
}
