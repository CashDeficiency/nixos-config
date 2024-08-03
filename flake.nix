{
  description = "NixOS configs for CashDeficiency";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    # define a list of hosts here
    nixosConfigurations = {
      macbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./macbook
          home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.cashd = import ./home.nix;
	  }
        ];
      };
    };
  };
}
