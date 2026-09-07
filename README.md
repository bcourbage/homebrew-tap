# bcourbage/homebrew-tap

Homebrew tap for [unison-ui-mac](https://github.com/bcourbage/unison-ui-mac), a native macOS GUI for the [Unison File Synchronizer](https://github.com/bcpierce00/unison).

## Install

```sh
brew install --cask bcourbage/tap/unison-ui
```

The fully-qualified cask name auto-adds the tap, so no separate `brew tap` step is needed.

## Requirements

- macOS 15 Sequoia or later
- Apple Silicon (arm64)

## Upgrading

The app updates itself through Sparkle, so it stays current without Homebrew.
Homebrew skips auto-updating casks on a normal `brew upgrade`; to force it to the
latest cask anyway:

```sh
brew upgrade --cask --greedy-auto-updates unison-ui
```

## Uninstall

```sh
brew uninstall --cask unison-ui
# Also remove preferences:
brew uninstall --cask --zap unison-ui
```

See the [main repo](https://github.com/bcourbage/unison-ui-mac) for documentation, changelog, and bug reports.
