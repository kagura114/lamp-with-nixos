{
  description = "LAMP for NixOS in incus container";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }@inputs: {
    nixosConfigurations = {
      container = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${inputs.nixpkgs}/nixos/modules/virtualisation/lxd-virtual-machine.nix"
        ./config.nix
        ];
      };
    };
  };
}

