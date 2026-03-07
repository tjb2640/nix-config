#!/bin/sh

sudo nix-collect-garbage -d
sudo nix-store --verify --repair --check-contents
rbs

