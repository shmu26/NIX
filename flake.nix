{
  description = "nixos";

  inputs = {
    nixpkgs = {
     # url = "github:NixOS/nixpkgs/nixos-unstable";
       url = "github:NixOS/nixpkgs/nixos-24.05";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
} 
