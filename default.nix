{ nixpkgs ? import <nixpkgs> {} }:

let pure-platform = import (builtins.fetchTarball https://github.com/grumply/pure-platform/tarball/f42ae470d0fa0ef4b7bf6e47edbc98350fafa08c) {};

in pure-platform.project ({ pkgs, ... }: {

  minimal = true;

  packages = {
    backend = ./app/backend;
    shared = ./app/shared;
    frontend = ./app/frontend;

    server = ./dev/server;
    dev = ./dev/dev;

  };

  overrides = self: super: {
  };

  shells = {
    ghc = [ "dev" "server" "backend" "shared" "frontend" ];
    ghcjs = [ "shared" "frontend" ];
  };

  tools = ghc: with ghc; [
    pkgs.haskellPackages.ghcid
    pkgs.haskellPackages.fsnotify
    pkgs.pkgs.dhall-json
  ];

})
