cask "mead" do
  arch arm: "arm64", intel: "amd64"

  version "0.10.5"
  sha256 arm:   "540c44dff1d4dfe9c46413818896d722630acacbcded0ab559c21688c179ebea",
         intel: "17e70e1801b9f8e1994c22e1a32916c3fddde5c349be673658df8945dd47fe64"

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
