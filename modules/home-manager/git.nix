{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_ed25519
        AddKeysToAgent yes
    '';
  };
  services.ssh-agent.enable = true;
  programs.git = {
    enable = true;
    userName = "vlmsk-code";
    userEmail = "vlad.maslennikov08@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "codium --wait";
      push.autoSetupRemote = true;
    };
  };
}
