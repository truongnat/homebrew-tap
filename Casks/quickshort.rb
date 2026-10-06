# Homebrew cask for the unsigned Quickshort build.
# Publish in a custom tap repo `truongnat/homebrew-tap` at Casks/quickshort.rb;
# the release workflow can bump version+sha256 automatically via TAP_TOKEN.
#
#   brew tap truongnat/tap
#   brew install --cask quickshort
cask "quickshort" do
  version "0.4.0"
  sha256 "1ca5afd244bc8df277bf24d79685352624abb9e033581a4d4f216ef53be014e7"

  url "https://github.com/truongnat/quickshort/releases/download/v#{version}/Quickshort-v#{version}-macos.zip"
  name "Quickshort"
  desc "Region screenshot tool with annotations and OCR"
  homepage "https://github.com/truongnat/quickshort"

  app "Quickshort.app"

  # unsigned build: strip quarantine so Gatekeeper doesn't block first launch
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Quickshort.app"],
        writable_paths: ["{{appdir}}/Quickshort.app"]
  end

  zap trash: [
    "~/.config/quickshort",
    "~/Library/LaunchAgents/ai.quickshort.plist",
  ]
end
