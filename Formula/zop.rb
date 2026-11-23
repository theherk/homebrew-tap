class Zop < Formula
  desc "Every project, ranked by use: list, refresh, and per-project tmp paths"
  homepage "https://github.com/theherk/zop"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/theherk/zop/releases/download/0.2.0/zop-darwin-arm64"
      sha256 "155db2eab4c5ae5f0c21da1ff9d7d05fdf7f931c31b88ec4fbf985388b556c5d"
    end
    on_intel do
      url "https://github.com/theherk/zop/releases/download/0.2.0/zop-darwin-amd64"
      sha256 "cfdde3d7637d86f03e73d61a926b32b8ded5e6f8b995a2c0935707ca36aea085"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/theherk/zop/releases/download/0.2.0/zop-linux-arm64"
      sha256 "46410e71de385962748512a11d9a61acf128c2c2edbe5215d6e10fec008baf5b"
    end
    on_intel do
      url "https://github.com/theherk/zop/releases/download/0.2.0/zop-linux-amd64"
      sha256 "2747367edb07c52d4a0001e5a7e92ae656826c70e8b9a85d9ec309eb39b9b317"
    end
  end

  def install
    bin.install Dir["zop-*"].first => "zop"
  end

  test do
    assert_match "zop", shell_output("#{bin}/zop --help")
  end
end
