# miso template

## How to build?

1. Install ghcjs-8.6.0.1_ghc-8.6.2 via nix
```bash
nix-channel --add https://nixos.org/channels/nixos-19.03 nixos
nix-channel --update
nix-env -f channel:nixos-19.03 -iA haskell.compiler.ghcjs
```
Or you can use any other ways, but it should be in your $PATH

2. Checkout Equations.yaml for a scripts to build project for ghc or ghcjs (I use my tool instead of Makefile or .sh files https://github.com/DoctorRyner/sae/releases)