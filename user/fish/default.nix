{ ... }: 
{
  programs.fish = {
    enable = true; 
    interactiveShellInit = ''
      if status is-interactive
        set -g fish_greeting ""

        alias rebuild-system="sudo nixos-rebuild switch --flake /home/mateus/repos/nixos#phalanx"
        alias check-system="sudo nixos-rebuild dry-activate --flake /home/mateus/repos/nixos#phalanx"
        alias test-system="sudo nixos-rebuild test --flake /home/mateus/repos/nixos#phalanx"
        alias ls="eza --icons --group-directories-first"
        alias lt="ls --tree"

        alias nix-shell="nix-shell --run fish"

        alias fzf='fzf --preview="bat --color=always {}"'
        alias ff='cd (find . -type d | fzf)'
        alias vzf='nvim (fzf)'

        alias icat="kitty +kitten icat"

        alias gemini="agy"
      end
    '';
  };
}
