{ ... }: {
  flake.homeManagerModules.fish = { pkgs, ... }: {
    home.packages = with pkgs; [
      grc
      libnotify
      fd
      bat
    ];

    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting ""
      '';

      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
      ];
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        add_newline = false;
        scan_timeout = 10;
        command_timeout = 500;

        format = ''
          $directory$git_branch$git_status$nodejs$python$rust$golang$cmd_duration$line_break$character
        '';

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vicmd_symbol = "[❮](bold green)";
        };

        directory = {
          truncation_length = 3;
          truncate_to_repo = true;
          style = "bold cyan";
          read_only = " ";
        };

        git_branch = {
          symbol = "";
          style = "bold purple";
          format = "[$symbol$branch]($style) ";
        };

        git_status = {
          style = "bold yellow";
          format = "([$all_status$ahead_behind]($style))";
          conflicted = "=";
          ahead = "⇡$count";
          behind = "⇣$count";
          diverged = "⇕⇡$ahead_count⇣$behind_count";
          untracked = "?$count";
          stashed = "";
          modified = "!$count";
          staged = "+$count";
          renamed = "»$count";
          deleted = "✘$count";
        };

        cmd_duration = {
          min_time = 2000;
          format = "[$duration]($style) ";
          style = "bold yellow";
        };

        nodejs = {
          symbol = "";
          detect_files = [
            "package.json"
            ".node-version"
            ".nvmrc"
          ];
          format = "[$symbol($version )]($style)";
        };

        python = {
          symbol = "";
          detect_files = [
            "requirements.txt"
            "pyproject.toml"
            "setup.py"
            "Pipfile"
          ];
          format = "[$symbol($version )]($style)";
        };

        rust = {
          symbol = "";
          detect_files = [ "Cargo.toml" ];
          format = "[$symbol($version )]($style)";
        };

        golang = {
          symbol = "";
          detect_files = [ "go.mod" ];
          format = "[$symbol($version )]($style)";
        };

        package.disabled = true;
        aws.disabled = true;
        gcloud.disabled = true;
        azure.disabled = true;
        kubernetes.disabled = true;
        docker_context.disabled = true;
        terraform.disabled = true;
        line_break.disabled = false;
      };
    };
  };
}
