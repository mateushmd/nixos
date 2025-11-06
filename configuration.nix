{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
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
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };
    defaultUserShell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    nano.enable = false;
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
      aseprite
      gimp3-with-plugins
      rars

      nerd-fonts.jetbrains-mono
    ];
  };

  systemd.tmpfiles.rules = map (e: "w /sys/bus/${e}/power/control - - - - auto") [
    "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
    "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
    "pci/devices/0000:00:14.0" # FCH SMBus Controller
    "pci/devices/0000:00:14.3" # FCH LPC bridge
    "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
    "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
    "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
    "usb/devices/1-3" # USB camera
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Just don't
  system.stateVersion = "24.11"; # Did you read the comment?
}
