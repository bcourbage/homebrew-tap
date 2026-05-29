# bcourbage/homebrew-tap

Homebrew tap for [unison-ui-mac](https://github.com/bcourbage/unison-ui-mac), a native macOS GUI for the [Unison File Synchronizer](https://github.com/bcruiser/unison).

## Install

```sh
brew tap bcourbage/tap
brew install --cask unison-ui-mac
```

Homebrew handles the macOS quarantine strip automatically; first launch is clean.

## Requirements

- macOS 15 Sequoia or later
- Apple Silicon (arm64)

## Upgrading

```sh
brew upgrade --cask unison-ui-mac
```

## Uninstall

```sh
brew uninstall --cask unison-ui-mac
# Also remove preferences:
brew uninstall --cask --zap unison-ui-mac
```

See the [main repo](https://github.com/bcourbage/unison-ui-mac) for documentation, changelog, and bug reports.
