cask "unison-ui-mac" do
  version "0.7.0"
  sha256 "9ac51948be398731cc905a42ffa39966e3e410ceb6b1aabee0a50bb6bfe08366"

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
  # anything else runs Unison's text interface. Occupant of bin/unison at install
  # (Homebrew 6.0.22, cask/artifact/symlinked.rb): a link into this app is
  # accepted; a formula's link is skipped with a warning; another resolving
  # target fails with "already a Binary"; a dangling link is replaced. Requires a release that ships
  # Contents/MacOS/cltool (0.7.0 or later); do not merge onto an earlier version.
  binary "#{appdir}/unison-ui-mac.app/Contents/MacOS/cltool", target: "unison"

  zap trash: "~/Library/Preferences/net.courbage.unison-ui-mac.plist"

  caveats <<~EOS
    When Homebrew links the app's command-line launcher as #{HOMEBREW_PREFIX}/bin/unison,
    `unison -ui graphic` opens the app and `unison -server` runs its embedded Unison.

    If the unison formula is linked, Homebrew keeps the formula's command and skips
    that link with a warning. #{HOMEBREW_PREFIX}/bin/unison, and any servercmd that
    names it, then run the formula, not this app. To give the command to the app,
    run `brew unlink unison` and then `brew reinstall --cask unison-ui-mac`.

    Machines that sync to this Mac should set servercmd in their profile to the full
    path of the executable they intend to run, checked with readlink. The PATH an
    incoming ssh command receives depends on this Mac's SSH and shell configuration.
    Details: https://github.com/bcourbage/unison-ui-mac/blob/main/MANUAL.md#repair-and-migration
  EOS
end
