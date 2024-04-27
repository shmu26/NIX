#Home Manager with zsh and oh-my-zsh
#for Plasma configuration, use konsave. To apply a profile: konsave -a <profile name>

{ pkgs, ... }: {
  home.username = "shmuel";
  home.homeDirectory = "/home/shmuel";
  programs.home-manager.enable = true;
  programs.zsh.initExtra = "neofetch|lolcat";
  home.packages = with pkgs; [
    pkgs.oh-my-zsh
    pkgs.neofetch
    pkgs.lolcat
    pkgs.zsh-autosuggestions
     ];

     dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};



  programs.zsh = {
   enable = true;
   autosuggestion.enable = true;

   shellAliases = {
    ll = "ls -l";
    bild = "cd /home/shmuel/nixos && sudo nixos-rebuild switch --flake ~/nixos#nixos && git add .  &&  git commit -m config && git push origin nixos-kde";
    up = "sudo nix-channel --update && sudo nixos-rebuild switch --flake ~/nixos#nixos";
    config = "nano -m -q -l +c/#pkgs -B ~/nixos/configuration.nix";
    hom = "nano -m -q -l -B ~/nixos/home.nix";
    nan = "nano -m -q -l";

  };
};
programs.zsh.oh-my-zsh = {
  enable = true;
  plugins = [  ];
  theme = "agnoster";
};
}

  #add home manager channel
#sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
#sudo nix-channel --update

#then add "pkgs.git" to "environment.systemPackages = with pkgs; [" in "/etc/nixos/configuration.nix" and then run "sudo nixos-rebuild switch"


#This config is on nixos-kde branch of NIX
