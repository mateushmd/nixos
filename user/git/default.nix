{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      commit.gpgsign = true;
      core.editor = "nvim";
      gpg.format = "ssh";
      init.defaultBranch = "main";
      merge.tool = "nvim";
      mergetool = {
        keepBackup = false;
        prompt = false;
        "nvim".cmd = "nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
      };
      rerere = {
        enable = true;
        rerere.autoUpdate = true;
      };
      user = {
        email = "mateushmdiniz@gmail.com";
        name = "mateushmd";
        signingkey = "~/.ssh/id_ed25519.pub";
      };
    };
  };
}
