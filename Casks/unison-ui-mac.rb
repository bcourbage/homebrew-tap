cask "unison-ui-mac" do
  version "0.1.4"
  sha256 "9f7b109be79e8372307c5547bf1802a2b8dafdd17993790c8b1c520fa7f2e086"

  url "https://github.com/bcourbage/unison-ui-mac/releases/download/v#{version}/unison-ui-mac-#{version}.app.zip"
  name "Unison-UI-Mac"
  desc "GUI for the Unison File Synchronizer"
  homepage "https://github.com/bcourbage/unison-ui-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "unison-ui-mac.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "/Applications/unison-ui-mac.app"],
                   sudo: true
  end

  zap trash: "~/Library/Preferences/net.courbage.unison-ui-mac.plist"
end
