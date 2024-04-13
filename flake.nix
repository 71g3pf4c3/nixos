{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixvim,
      stylix,
      self,
      nix-flatpak,
      nix-colors,
    }@inputs:
    {
      nixosConfigurations = {
        paduse = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit self inputs;
          };
          modules = [
            ./hosts/paduse/configuration.nix
            ./hosts/paduse/hardware-configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = false;
                users.t1g3pf4c3.imports = [ ./home ];
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
          ];
        };
        asuse = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit self inputs;
          };
          modules = [
            ./hosts/asuse/hardware-configuration.nix
            ./hosts/asuse/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = false;
                users.t1g3pf4c3.imports = [ ./home/desktop ./home/terminal ./home/xdg.nix ./home/home.nix ];
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
          ];
        };
      };
    };
}
