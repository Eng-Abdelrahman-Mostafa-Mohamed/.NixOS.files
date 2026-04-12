{ pkgs, lib, ... }:
{
  files = {
    ".yamllint.yaml".yaml = {
      extends = "default";
      rules = {
        document-start = "disable";
        truthy = "disable";
        comments = "disable";
        line-length.max = 120;
      };
    };
    ".yamlfmt.yaml".yaml = {
      formatter = {
        type = "basic";
        line_ending = "lf";
        max_line_length = 140;
        trim_trailing_whitespace = true;
        eof_newline = true;
        force_array_style = "block";
      };
    };
    "statix.toml".toml = {
      ignore = [
        ".direnv"
        "**/hardware-configuration.nix"
      ];
    };
  };

  languages = {
    nix = {
      enable = true;
      lsp.enable = true;
    };
  };

  opencode = {
    enable = true;
    settings = {
      mcp = {
        github = {
          type = "remote";
          url = "https://api.githubcopilot.com/mcp";
          headers = {
            Authorization = "{env:GITHUB_PERSONAL_ACCESS_TOKEN}";
          };
        };
        nixos = {
          type = "local";
          command = [ "${lib.getExe pkgs.mcp-nixos}" ];
        };
        devenv = {
          type = "local";
          command = [
            "devenv"
            "mcp"
          ];
        };
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
      };
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

  git-hooks = {
    package = pkgs.pre-commit;
    hooks = {
      action-validator.enable = true;
      actionlint.enable = true;
      nixfmt.enable = true;
      check-added-large-files.enable = true;
      check-case-conflicts.enable = true;
      check-json.enable = true;
      check-merge-conflicts.enable = true;
      check-toml.enable = true;
      check-vcs-permalinks.enable = true;
      check-symlinks.enable = true;
      check-xml.enable = true;
      check-yaml.enable = true;
      comrak.enable = true;
      deadnix.enable = true;
      detect-private-keys.enable = true;
      markdownlint.enable = true;
      mixed-line-endings.enable = true;
      yamlfmt.enable = true;
      ripsecrets.enable = true;
      statix.enable = true;
      taplo.enable = true;
      trim-trailing-whitespace.enable = true;
      trufflehog.enable = true;
      yamllint.enable = true;
      nixf-diagnose.enable = true;
    };
  };

  treefmt = {
    enable = true;
    config = {
      programs = {
        actionlint.enable = true;
        jsonfmt.enable = true;
        nixf-diagnose.enable = true;
        nixfmt.enable = true;
        deadnix.enable = true;
        oxipng.enable = true;
        statix.enable = true;
        taplo.enable = true;
        xmllint.enable = true;
        yamlfmt.enable = true;
      };
      settings = {
        formatter = {
          taplo-format = {
            command = "${lib.getExe pkgs.taplo}";
            options = [ "format" ];
            includes = [ "*.toml" ];
            excludes = [
              ".git/*"
              ".devenv/*"
            ];
          };
        };
      };
    };
  };
}
