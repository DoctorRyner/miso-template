# miso-template

## Build using GHC

Just run `stack build`
## Build using GHCJS

1. You must somehow install ghcjs (tested with ghcjs-8.6.0.1_ghc-8.6.2). I did it via nix

```bash
nix-channel --add https://nixos.org/channels/nixos-19.03 nixos
nix-channel --update
nix-env -f channel:nixos-19.03 -iA haskell.compiler.ghcjs
```

2. Run `stack build --stack-yaml "stack-ghcjs.yaml"` and wait until it will be stucked while trying to download and build dependencies, you can see it if it stucks at 0 / ?? for a some time, then you need to interrupt it (just press cmd / ctrl + c). We need to do this only to generate necessary files because stack can't build using latest ghcjs

3. Run `cabal new-build all --project=cabal-ghcjs.project` to actually download dependencies and build it to html and js files