class Zop < Formula
  desc "Every project, ranked by use: list, refresh, and per-project tmp paths"
  homepage "https://github.com/theherk/zop"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/theherk/zop/releases/download/0.3.0/zop-darwin-arm64"
      sha256 "9285820a27953541decb62aec18e974b8fc5945fd24e0a57f92bfda190f3f099"
    end
    on_intel do
      url "https://github.com/theherk/zop/releases/download/0.3.0/zop-darwin-amd64"
      sha256 "27552698ade557dcf33c0b1c17d106ce91a901fb3328afce8a54c278f0d192e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/theherk/zop/releases/download/0.3.0/zop-linux-arm64"
      sha256 "a4955579fb2a1634d3843c693c0d3a3753b44fc4420f069e5e5ff85474d5cbb7"
    end
    on_intel do
      url "https://github.com/theherk/zop/releases/download/0.3.0/zop-linux-amd64"
      sha256 "2aae3f41f9c91e3d00015275408825990a9635ce424fe33766a89928a2f429b2"
    end
  end

  def install
    bin.install Dir["zop-*"].first => "zop"
  end

  test do
    assert_match "zop", shell_output("#{bin}/zop --help")
  end
end
