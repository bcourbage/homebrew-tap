cask "unison-ui-mac" do
  version "0.1.1"
  sha256 "d2b6e3b98e30bcd2b7159afe77aa927974d426e45cbd0714fea59c227c68c7ef"

  url "https://github.com/bcourbage/unison-ui-mac/releases/download/v#{version}/unison-ui-mac-#{version}.app.zip"
  name "Unison-UI-Mac"
  desc "GUI for the Unison File Synchronizer"
  homepage "https://github.com/bcourbage/unison-ui-mac"

  # Mirror the .app's hard requirements so brew refuses to install on
  # incompatible hosts rather than letting the bundle quarantine into
  # an unusable state.
  depends_on macos: :sequoia
  depends_on arch: :arm64

  # The .app inside the zip — brew symlinks it into /Applications.
  app "unison-ui-mac.app"

  # `brew uninstall --zap` removes user defaults too. Logs go to the
  # unified log (Console.app), not disk, so nothing else to clean.
  zap trash: "~/Library/Preferences/net.courbage.unison-ui-mac.plist"
end
