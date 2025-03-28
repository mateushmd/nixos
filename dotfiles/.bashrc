#!bin/bash
alias fzf='fzf --preview="bat --color=always {}"'
alias ff='cd $(find * -type d | fzf)'
alias vzf='vi $(fzf)'

alias rebuild-flake="sudo nixos-rebuild switch --flake '/home/mateus/nixos-flake'"
alias ls="eza --icons --group-directories-first"
