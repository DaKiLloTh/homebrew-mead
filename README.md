# homebrew-mead

Homebrew tap for [mead](https://github.com/DaKiLloTh/mead), a native Homebrew GUI for macOS. See [getmead.app](https://getmead.app).

## Install

```sh
brew tap DaKiLloTh/mead
brew install --cask mead
```

## About the unsigned build

mead's releases are unsigned (no paid Apple Developer ID). This cask's
`postflight` block removes the Gatekeeper quarantine flag automatically on
install, so `brew install --cask mead` works without the manual
`xattr -dr com.apple.quarantine` step that a direct DMG/zip download from
[the main repo's releases](https://github.com/DaKiLloTh/mead/releases)
would otherwise need.

mead is pre-alpha software. Expect bugs and breaking changes between
releases until it reaches 1.0.

## macOS Apple Silicon (arm64) or Intel (amd64).
