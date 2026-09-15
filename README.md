# Homebrew tap for Axiom

```bash
brew tap branshlee/axiom
brew install axiom          # the binary, empty knowledge
brew install axiom-full     # the binary plus a knowledge snapshot
```

Then `axiom init` (or `axiom init --from "$(brew --prefix axiom-full)/share/axiom-full/knowledge"`)
and `axiom` to enter a session. Binaries: macOS Apple Silicon, Linux x86_64.
