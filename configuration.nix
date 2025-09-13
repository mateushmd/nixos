{ config, inputs, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      settings = { 
        username.show_always = true;
        os.disabled = false;
      };
    };
    fish.enable = true;
  };

  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      vim
      inputs.nixvim.packages.${pkgs.system}.default
      git
      unzip
      bat
      nerd-fonts.jetbrains-mono
    ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

}
