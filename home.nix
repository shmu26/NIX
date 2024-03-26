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


  programs.zsh = {
   enable = true;
   enableAutosuggestions = true;

   shellAliases = {
    ll = "ls -l";
    bild = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
    up = "sudo nix-channel --update && sudo nixos-rebuild switch --flake ~/nixos#nixos";
    config = "nano ~/nixos/configuration.nix";
    hom = "nano ~/nixos/home.nix";

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
#This config is on master branch of NIX
