cask "unison-ui-mac" do
  version "0.6.1"
  sha256 "faf479546e71cacc304f48d30a45894328ba99bd5edfe61820f118bcc9115223"

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
  # The app's command-line launcher, linked as `unison`. Unison itself decides
  # what an invocation means: `unison -ui graphic` opens the app, `unison -server`
  # (what a remote peer runs over ssh) serves with the embedded engine, and
  # anything else runs Unison's text interface. Requires a release that ships
  # Contents/MacOS/cltool (0.7.0 or later); do not merge onto an earlier version.
  binary "#{appdir}/unison-ui-mac.app/Contents/MacOS/cltool", target: "unison"

  zap trash: "~/Library/Preferences/net.courbage.unison-ui-mac.plist"

  caveats <<~EOS
    The app's command-line launcher is linked as #{HOMEBREW_PREFIX}/bin/unison, so
    `unison -ui graphic` opens the app and `unison -server` runs its embedded Unison.

    If the unison formula is linked, this install stops with "already a Binary".
    Run `brew unlink unison` and retry, or install the app from the release zip to
    keep the formula's command.

    Commands arriving over ssh do not have #{HOMEBREW_PREFIX}/bin on their PATH.
    Machines that sync to this Mac should set servercmd = #{HOMEBREW_PREFIX}/bin/unison
    in their profile.
  EOS
end
