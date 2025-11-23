{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        email = "mateushmdiniz@gmail.com";
        name = "mateushmd";
      };
      init.defaultBranch = "main";
      core.editor = "nvim";
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
    };
  };
}
