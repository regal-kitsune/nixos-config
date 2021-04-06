# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  
  # Set your time zone.
  time.timeZone = "America/Chicago";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Network:
  networking = {
    hostName = "laptop";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    enableIPv6 = false;
    firewall.enable = true;
    networkmanager.enable = true;
  };
  
  # Enable CUPS:
  services.printing.enable = true;
  
  # Enable bluetooth:
  hardware.bluetooth.enable = true;
  
  # Enable sound:
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # X server:
  services.xserver = {
    videoDrivers = [ "radeon" ];
    enable = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };
  
  # Add users:
  users.mutableUsers = true;
  users.users.madelyn = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/madelyn";
    extraGroups = [ "wheel" "storage" "power" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
  
  # Enable auto upgrade:
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # Enable gc automatically:
  nix.gc = {
    dates = "weekly";
    automatic = true;
  };

  # Allow non-free:
  nixpkgs.config.allowUnfree = true;
  
  # System packages:
  environment.systemPackages = with pkgs; [
    # Console:
    jdk
    bash
    file
    lsof
    rsync
    gnupg
    p7zip
    unzip
    unrar
    nettools
    neofetch
    youtube-dl
    xorg.xkill
    xorg.xrandr
    xorg.xinit
    xorg.xmodmap
    # Drivers:
    epson-escpr
    # Fonts:
    corefonts
    noto-fonts-cjk
    # Development:
    git
    zeal
    maven
    gradle 
    groovy
    netbeans
    kdevelop
    smartgithg
    jetbrains.pycharm-community
    # Fcitx:
    fcitx
    fcitx-configtool
    fcitx-engines.mozc
    # Internet:
    firefox
    tdesktop
    ktorrent
    konversation
    # Games:
    steam
    lutris
    discord
    # Graphics:
    krita
    gwenview
    spectacle
    kcolorchooser
    # Office:
    okular
    qownnotes
    libreoffice
    thunderbird
    # Education:
    anki
    tagainijisho
    # Multimedia:
    vlc
    cantata
    obs-studio
    # Accesories:
    kate
    kcalc
    # System:
    ark
    konsole
    dolphin
    ksysguard
    keepassxc
    ksystemlog
    # Security
    clamav
    openvpn
    firejail
    bleachbit
    chkrootkit    
  ];

  # Application configs:
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.clamav = {
    updater.enable = true;
    daemon.enable = true;
    updater.interval = "daily";
    updater.frequency = 5;
  };
  
  # Enable the OpenSSH daemon.
  services.openssh.enable =  true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

