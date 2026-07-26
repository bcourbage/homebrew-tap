cask "unison-ui-mac" do
  version "0.4.0"
  sha256 "3e38b1150900e7e1d139267935888d3d93f9d70b76258cbf6d71b8ea1c0f506c"

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
