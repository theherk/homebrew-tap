class RhuideanStudio < Formula
  desc "Polyrhythmic orbital music visualizer"
  homepage "https://github.com/theherk/rhuidean-studio"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/theherk/rhuidean-studio/releases/download/0.3.2/rhuidean-studio-darwin-arm64"
      sha256 "238ab289388b6281c40789ab49720886229b8a191e35372aecfa231073ed73ec"
    end
    on_intel do
      url "https://github.com/theherk/rhuidean-studio/releases/download/0.3.2/rhuidean-studio-darwin-amd64"
      sha256 "e16ffbf9694160dacbf1b7c74cde033de2881aaba9135a530e920d64cbaf8c0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/theherk/rhuidean-studio/releases/download/0.3.2/rhuidean-studio-linux-arm64"
      sha256 "fc4510a8df3ad287afc474990fb1a96a1bf2d4c8d24323f1cef3c0801b073e81"
    end
    on_intel do
      url "https://github.com/theherk/rhuidean-studio/releases/download/0.3.2/rhuidean-studio-linux-amd64"
      sha256 "5afebf8d1a41f91e4e41aea101d21526a18dba7f0eea2fb717e79078876f6736"
    end
  end

  def install
    bin.install Dir["rhuidean-studio-*"].first => "rhuidean-studio"
  end

  test do
    assert_match "rhuidean-studio", shell_output("#{bin}/rhuidean-studio --version")
  end
end
