cask "mead" do
  arch arm: "arm64", intel: "amd64"

  version "0.10.4"
  sha256 arm:   "94e6ebdc377fe2e3c741f37ad6f3a183d27def6c31e9f1fba15de3a27b7f0a84",
         intel: "4ef1b49051fc5f583e6201708ee2767c6cf208f23779f79da0e7b24c2e703780"

  url "https://github.com/DaKiLloTh/homebrew-mead/releases/download/v#{version}/mead-v#{version}-macos-#{arch}.dmg"
  name "mead"
  desc "Native Homebrew GUI for macOS"
  homepage "https://getmead.app"

  depends_on macos: :sonoma

  app "mead.app"

  # mead's release builds are unsigned (no paid Apple Developer ID), so a
  # plain download would get Gatekeeper-quarantined and refuse to launch on
  # first open. Homebrew's own --no-quarantine flag for the official
  # homebrew-cask repo is being retired (see Homebrew/brew#20755) as part of
  # tightening what that repo accepts, but a third-party tap's own cask
  # definition isn't bound by that policy -- stripping the quarantine
  # attribute ourselves in postflight, on our own tap, achieves the same
  # practical outcome without depending on a flag Homebrew is removing.
  postflight do
    system_command "/usr/bin/xattr",
                    args: ["-dr", "com.apple.quarantine", "#{appdir}/mead.app"],
                    sudo: false
  end

  zap trash: [
    "~/Library/Application Support/mead",
    "~/Library/Saved Application State/com.wails.mead.savedState",
  ]

  caveats do
    <<~EOS
      mead is pre-alpha software: expect bugs, and expect breaking changes
      between releases until it reaches a stable 1.0.

      Release notes: https://github.com/DaKiLloTh/mead/releases/tag/v#{version}
    EOS
  end
end
