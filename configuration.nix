# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Sane Scanner
     hardware.sane.enable = true; 
     hardware.sane.disabledDefaultBackends = [ ".*" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

#local time
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
   xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

#Brother printer
  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

#NTFS
  boot.supportedFilesystems = [ "ntfs" ];

#Automount

fileSystems."/run/media/shmuel/PersonalData" = {
    device = "/dev/disk/by-uuid/22EC446AEC4439F5";
    options = ["nofail"];
};

fileSystems."/run/media/shmuel/LinuxBackups" = {
    device = "/dev/disk/by-uuid/af74cd67-484c-4de5-bb96-e86db774d910";
    options = ["nofail"];
};

fileSystems."/run/media/shmuel/VM" = {
    device = "/dev/disk/by-uuid/701FE3AE54D4CE16";
    options = ["nofail"];
};
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shmuel = {
    isNormalUser = true;
    description = "shmuel";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

#swap
    zramSwap.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

#Shell
  users.users.shmuel.shell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
pkgs.xfce.mousepad
     pkgs.deja-dup
     pkgs. duplicity
     pkgs.ntfs3g
     pkgs.google-chrome
     pkgs.audacious
     pkgs.timeshift
     pkgs.gparted
     pkgs.conky
     pkgs.goldendict-ng
     pkgs.losslesscut-bin
     pkgs.vlc
     pkgs.smplayer
     pkgs.libreoffice
     pkgs.handbrake
     pkgs.media-downloader
     pkgs.inxi
     pkgs.simple-scan
     pkgs.git
     pkgs.gh
     pkgs.vim
     pkgs.wget
     pkgs.curl
     pkgs.galculator
     pkgs.oh-my-zsh
     pkgs.neofetch
     pkgs.lolcat
     pkgs.zsh-autosuggestions
     pkgs.zoom-us
     pkgs.libressl
     pkgs.hebcal
     pkgs.gnome.dconf-editor
     pkgs.gnome.gnome-tweaks    
     pkgs.gnome-extension-manager
     pkgs.git-credential-manager
     pkgs.gnomeExtensions.dash-to-panel
     pkgs.gnomeExtensions.media-controls
     pkgs.gnomeExtensions.appindicator
     pkgs.gnomeExtensions.clipboard-indicator
     pkgs.gnomeExtensions.arcmenu
     pkgs.gnomeExtensions.lock-screen
     pkgs.gnomeExtensions.executor     
     pkgs.papirus-icon-theme
     pkgs.drawing
     pkgs.yaru-theme 

     pkgs.btrfs-progs
     pkgs.btrfs-assistant
 ];

  services.btrbk.instances."btrbk" = {
    onCalendar = "*:1/10";
    settings = {
      snapshot_preserve_min = "7d";
      volume."/" = {
        subvolume = "/home";
        snapshot_dir = ".snapshots";
      };
    };
  };

  virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

programs.zsh = {
   enable = true;
   autosuggestions.enable = true;
   shellInit = "neofetch|lolcat";
   
   shellAliases = {
    ll = "ls -l";
    fax = "brpcfax -o fax-number=025389272 /home/shmuel/Downloads/Fax/*";
    del = "rm /home/shmuel/Downloads/Fax/*";
    bild = "sudo nixos-rebuild switch && cp /etc/nixos/configuration.nix ~/Documents/config && cd ~/Documents/config && git add .  && git commit -m config && git push origin main";
    up = "sudo nix-channel --update && sudo nixos-rebuild switch && cd ~/Documents/config && git add configuration.nix && git commit -m config && git push origin main";
    config = "sudo nano /etc/nixos/configuration.nix";
  };
};
programs.zsh.ohMyZsh = {
  enable = true;
  plugins = [  ];
  theme = "agnoster";
};

# Prevent the new user dialog in zsh
system.userActivationScripts.zshrc = "touch .zshrc";

  # List services that you want to enable:
      services.flatpak.enable = true;
      services.avahi.enable = true;
      services.btrfs.autoScrub.enable = true;

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

# Set channel by running this command:
# sudo nix-channel --add https://channels.nixos.org/nixos-unstable
# sudo nix-channel --update
# sudo nixos-rebuild switch --upgrade

# Configure printer:
# ipp://192.168.150.170:631
# Brother MFC-L2710DW series, using brlaser v6
