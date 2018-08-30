#!/bin/sh

set -eux

wget https://github.com/dapphub/dapptools/archive/master.zip
unzip master.zip
mv dapptools-master dapptools
cd dapptools
cd src/libethjet
nix-env -iA cachix -f https://github.com/NixOS/nixpkgs/tarball/1d4de0d552ae9aa66a5b8dee5fb0650a4372d148
echo \"trusted-users = root $USER\" | sudo tee -a /etc/nix/nix.conf && sudo pkill nix-daemon
cachix use dapp
sed -i.bak "s/{ stdenv, secp256k1 }:/with import <nixpkgs> {};/" default.nix
nix-env -i secp256k1
nix-env -f . -i libethjet
