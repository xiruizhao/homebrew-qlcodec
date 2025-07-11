cask "qlcodec" do
  version "1.1"
  sha256 "49d4877031c3298d491f78d41fb9eba7d768ae35e9edcc698a33c2df2335acf4"

  url "https://github.com/Oil3/QLCodec/releases/download/QLC-#{version}-universalBinary/QLCodec.#{version}-.UniversalBinary.zip",
      verified: "github.com/Oil3/QLCodec"
  name "QLCodec"
  desc "Quick Look Extension for video and audio formats not natively supported by macOS"
  homepage "https://github.com/Oil3/QLCodec"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  auto_updates true
  depends_on macos: ">= :sequoia"

  app "QLC.app"
end
