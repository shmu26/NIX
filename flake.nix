{
    inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-snapd.url = "github:io12/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-snapd }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      nix-snapd.nixosModules.default

      {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.shmuel = import ./home.nix;
    services.snap.enable = true;
  }
      ];

    };
  };
}
