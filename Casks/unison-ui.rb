cask "unison-ui" do
  version "0.9.0"
  sha256 "3cee4a8533e79ca9a9b695974fc7ddf10fa7c8f9ef42be7c1db7e99954724fd6"

  url "https://github.com/bcourbage/unison-ui-mac/releases/download/v#{version}/unison-ui-mac-#{version}.app.zip"
  name "Unison UI for macOS"
  name "Unison-UI-Mac"
  desc "GUI for the Unison File Synchronizer"
  homepage "https://bcourbage.github.io/unison-ui-mac/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Developer ID-signed and notarized; updates itself through Sparkle.
  auto_updates true
  # Upstream's Unison.app also links its launcher as bin/unison.
  conflicts_with cask: "unison-app"
  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "unison-ui-mac.app"
  # `unison -ui graphic` opens the app and `unison -server` serves with the
  # embedded engine; a bare `unison <profile>` follows the Default interface
  # preference (Graphical by default), and `-ui text` runs the text interface.
  # When the unison formula owns bin/unison, Homebrew keeps the formula's link
  # and skips this one.
  binary "#{appdir}/unison-ui-mac.app/Contents/MacOS/cltool", target: "unison"

  # ~/Library/Application Support/Unison holds user-written profiles and sync
  # archives shared with every Unison build, so it is deliberately not zapped.
  zap trash: [
    "~/Library/Caches/net.courbage.unison-ui-mac",
    "~/Library/HTTPStorages/net.courbage.unison-ui-mac",
    "~/Library/Preferences/net.courbage.unison-ui-mac.plist",
    "~/Library/WebKit/net.courbage.unison-ui-mac",
  ]

  caveats <<~EOS
    The app's command-line launcher is linked as #{HOMEBREW_PREFIX}/bin/unison.
    If the unison formula is linked, Homebrew keeps the formula's command instead.
    To give the command to the app: brew unlink unison && brew reinstall --cask unison-ui
  EOS
end
