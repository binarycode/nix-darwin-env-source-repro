{
  inputs = {
    nix-darwin-bad = {
      url = "github:nix-darwin/nix-darwin/36a15e8c6c4686be29ccbf0ae0ac1d6133074615";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin-good = {
      url = "github:nix-darwin/nix-darwin/b833d4a32d965e6393a63b2c91b46eca2a5030d8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
  };

  outputs = inputs: {
    darwinConfigurations = let
      configuration = {
        system = "aarch64-darwin";
        modules = [
          ({
            services.nix-daemon.enable = true;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            environment.etc."flake.nix".source = ./flake.nix;
          })
        ];
      };
    in {
      bad = inputs.nix-darwin-bad.lib.darwinSystem configuration;
      good = inputs.nix-darwin-good.lib.darwinSystem configuration;
    };
  };
} 
