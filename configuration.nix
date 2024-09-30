# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";

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

  # Sane Scanner
     hardware.sane.enable = true;
     hardware.sane.disabledDefaultBackends = [ ".*" ];

     #Kernel
      boot.kernelPackages = pkgs.linuxPackages_latest;
    

   # Virtualisation
   #  virtualisation.libvirtd.enable = true;
   #  programs.virt-manager.enable = true;
     # virtualisation.vmware.host.enable = true;
      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = [ "shmuel" ];
      virtualisation.virtualbox.host.enableExtensionPack = true;
   

  #swap
    zramSwap.enable = true;


  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";
 
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

#local time
services.geoclue2.enable = true;
services.localtimed.enable = true;



  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;


   environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  plasma-browser-integration
  oxygen
];


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
  #sound.enable = true; #disabled for unstable branch
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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shmuel = {
    isNormalUser = true;
    description = "shmuel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

          ];
  };

   # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Shell
  users.users.shmuel.shell = pkgs.zsh;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim
  wget
  google-chrome
  kate
  xfce.mousepad
  deja-dup
  duplicity
  ntfs3g
  caffeine-ng
  audacious
  timeshift
  gparted
  conky
  goldendict-ng
  losslesscut-bin
  vlc
  smplayer
  libreoffice
  handbrake
  media-downloader
  inxi
  simple-scan
  git
  gh
  curl
  galculator
  oh-my-zsh
  fastfetch
  lolcat
  zsh-autosuggestions
  zoom-us
  libressl
  hebcal
  zram-generator
  galculator
  fh
  filelight
  parted
  git-credential-manager
  exfat
  anydesk
  tartube-yt-dlp
  ffmpeg_7-full
  mplayer
  element-desktop
  firefox
  pciutils
  unixtools.top
  virtiofsd
  kdePackages.sddm-kcm
  kdePackages.kdeconnect-kde
  
  # guestfs-tools
  
     
#pkgs
   ];


 nixpkgs.config.permittedInsecurePackages = [
                "python3.12-youtube-dl-2021.12.17" 
                "python3.11-youtube-dl-2021.12.17"
              ];



   programs.zsh = {
   enable = true;
   autosuggestions.enable = true;
   shellInit = "fastfetch|lolcat";

   shellAliases = {
    bild = "cd /etc/nixos && sudo nixos-rebuild switch --flake .  && cp /etc/nixos/configuration.nix ~/Documents/config && cp /etc/nixos/flake.nix ~/Documents/config && cp /etc/nixos/flake.lock ~/Documents/config &&  cp /etc/nixos/hardware-configuration.nix ~/Documents/config && cp /etc/nixos/configuration.nix~ ~/Documents/config && cd ~/Documents/config && git add .  && git commit -m config && git push origin main";
    config = "sudo nano -m -q -l +c/#pkgs -B  /etc/nixos/configuration.nix";
    nan = "nano -m -q -l";
    up = "cd /etc/nixos/ && sudo nix flake update";
    clean = "sudo nix-collect-garbage -d && sudo nix-store --gc && sudo nixos-rebuild boot";
    opt = "sudo nix-store --optimise";
    fax = "brpcfax -o fax-number=025389272 /home/shmuel/Downloads/Fax/*";
    del = "rm /home/shmuel/Downloads/Fax/*";
  };
};
programs.zsh.ohMyZsh = {
  enable = true;
  plugins = [  ];
  theme = "agnoster";
};

# Prevent the new user dialog in zsh
system.userActivationScripts.zshrc = "touch .zshrc";

     # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;
   # services.flatpak.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;

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
