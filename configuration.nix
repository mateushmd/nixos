{ self, config, inputs, pkgs, ... }:
{
  imports =
  [ 
    ./hardware-configuration.nix
  ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
        variant = "";
      };
    };
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
  };

  console.keyMap = "br-abnt2";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;

  users = {
    users.mateus = {
      isNormalUser = true;
      description = "mateus";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };
    defaultUserShell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    ssh = {
      startAgent = true;
      enableAskPassword = true;
      askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
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
    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";
    systemPackages = with pkgs; [
      wezterm
      kitty

      vim 
      inputs.nixvim.packages.${pkgs.system}.default 
      git
      zip
      unzip    
      fzf
      bat
      gitmoji-cli
      
      kdePackages.ksshaskpass
      gparted

      eza
      neofetch
      btop

      discord
      obsidian
      anydesk
      kdePackages.kcalc
      floorp
      vlc

      jdk
      iverilog

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

  # Just don't 
  system.stateVersion = "24.11"; # Did you read the comment?
}
