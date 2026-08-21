cask "unison-ui-mac" do
  version "0.5.0"
  # Filled at release cut from the notarized asset:
  #   shasum -a 256 unison-ui-mac-0.5.0.app.zip
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/bcourbage/unison-ui-mac/releases/download/v#{version}/unison-ui-mac-#{version}.app.zip"
  name "Unison-UI-Mac"
  desc "GUI for the Unison File Synchronizer"
  homepage "https://github.com/bcourbage/unison-ui-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app is Developer ID-signed and notarized, so no quarantine strip is
  # needed, and it updates itself through Sparkle rather than through brew.
  auto_updates true

  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "unison-ui-mac.app"

  zap trash: "~/Library/Preferences/net.courbage.unison-ui-mac.plist"
end
