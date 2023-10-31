{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland=
      {url = "github:hyprwm/Hyprland";
        # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, home-manager, hyprland,  ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixpkgs.overlays = [
    (self: super: {
       waybar = super.waybar.overrideAttrs (oldAttrs: {
           mesonFlags = oldAttrs.mesonFlags ++ [
              "-Dexperimental=true" ];
       });
     })
    ];
    nixosConfigurations = {
      surface = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.rafgani = ./home-manager/home.nix;
            };
          }
          hyprland.nixosModules.default
          { programs.hyprland.enable = true; }
        ];
#         nixpkgs.overlays = [
#           (self: super: {
#              waybar = super.waybar.overrideAttrs (oldAttrs: {
#              mesonFlags = oldAttrs.mesonFlags ++ [
#                                   "-Dexperimental=true" ];
#              });
#           })
#         ];
      };
    };
  };
}
