{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-alien.url = "github:thiagokokada/nix-alien";
		nixos-06cb-009a-fingerprint-sensor = {
    url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, nix-alien, self, nixos-06cb-009a-fingerprint-sensor, ... }: {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit self; };
          modules = [
            ./configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
						nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
						nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.t1g3pf4c3 = import ./home.nix;
            }
          ];
        };
      };
    };
}
