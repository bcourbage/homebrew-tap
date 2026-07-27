cask "unison-ui-mac" do
  version "0.4.1"
  sha256 "381e486a1b7d2094bcbf6abc5421b8e72178112752d4750d90e27c5a601baf2d"

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
