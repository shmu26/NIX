{
  description = "nixos";

inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nix-snapd.url = "github:io12/nix-snapd";
        nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, nix-snapd }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
         nix-snapd.nixosModules.default
         {
          services.snap.enable = true;
        }
        ];
      };
    };
  };
} 
