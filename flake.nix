{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # stylix.url = "github:danth/stylix";
    nix-alien.url = "github:thiagokokada/nix-alien";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland.url = "github:hyprwm/Hyprland";

  };

  outputs =
    { nixpkgs
    , home-manager
    , nixos-hardware
    , nix-alien
    , self
    , nixos-06cb-009a-fingerprint-sensor
    , devenv
    , microvm
      # , stylix
    , ...
    }@inputs: {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit self inputs; };
          modules = [
            ./configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
            nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
            nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
            # stylix.nixosModules.stylix
            # hyprland.nixosModules.default
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
