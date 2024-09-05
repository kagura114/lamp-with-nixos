# Intro
This is to build a LAMP environment for my class. We use NixOS + httpd + mariadb + PHP for this configuration and incus/lxc for container support.\
This image can be built without NixOS but `nix` is needed (of course). And can run on your incus installation.
# All in one script
# USE WITH CAUTION
```
git clone https://github.com/kagura114/lamp-with-nixos.git
cd lamp-with-nixos
sudo incus image import --alias kagura/lamp $(nix build .\#nixosConfigurations.container.config.system.build.metadata --print-out-paths --extra-experimental-features nix-command --extra-experimental-features flakes)/tarball/nixos-system-x86_64-linux.tar.xz $(nix build .\#nixosConfigurations.container.config.system.build.qemuImage --print-out-paths --extra-experimental-features nix-command --extra-experimental-features flakes)/nixos.qcow2
```

# Build (with flakes)
```
nix build .\#nixosConfigurations.container.config.system.build.metadata --print-out-paths --extra-experimental-features nix-command --extra-experimental-features flakes
nix build .\#nixosConfigurations.container.config.system.build.qemuImage --print-out-paths --extra-experimental-features nix-command --extra-experimental-features flakes
```
Each command returns a path like `/nix/store/nvk2d02901x3v7frvv3k69g1yqdsk5pw-nixos-disk-image` & ` /nix/store/xnnhhcv29r4igb6xgrsx9az6nks2al7p-tarball` , remember it.

# Run with incus
```
$ incus image import --alias kagura/lamp /nix/store/xnnhhcv29r4igb6xgrsx9az6nks2al7p-tarball/tarball/nixos-system-x86_64-linux.tar.xz /nix/store/g7x4zzqk2qc54jbhxds3b23xlfv2dl81-nixos-disk-image/nixos.qcow2
```
- `sudo` if you use privileged lxc
- first argument is the path of the tarball, built by the second command
- later one is the path of the image
- file names are always `tarball/nixos-system-x86_64-linux.tar.xz` and `nixos.qcow2` 

# Preinstalled applications
- LAMP stack
- NixOS default packages
- helix: for editing
- bat: to replace `cat`
This can be configured through 'config.nix'

# Info
- [Incus on NixOS wiki](https://wiki.nixos.org/wiki/Incus)
