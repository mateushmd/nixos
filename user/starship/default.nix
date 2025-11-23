{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      username.show_always = true;
      os.disabled = false;
    };
  };
}
