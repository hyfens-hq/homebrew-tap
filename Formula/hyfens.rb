class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.3/hyfens-0.1.3-macos-arm64.tar.gz"
      sha256 "389de2650109ed87aa9f688f562a79df2f34cc5fd907eecbc551603639439fff"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.3/hyfens-0.1.3-macos-x64.tar.gz"
      sha256 "f6b508474e24812e5cec821b5505001c463b26fc7d1f3ddcc0998a69c7dcecaa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.3/hyfens-0.1.3-linux-arm64.tar.gz"
      sha256 "844680d7ecd56125c0517a14f341e44c8e429907665d0be24d934ee14c0feda8"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.3/hyfens-0.1.3-linux-x64.tar.gz"
      sha256 "2f29e481a91d2094a9a20c66c14e08c01333b03cfc817b2e8d098ae7a5d63690"
    end
  end

  def install
    root_dir = if File.exist?("bin/hyfens")
      "."
    else
      Dir["hyfens-*"].find { |entry| File.exist?("#{entry}/bin/hyfens") }
    end
    raise "Hyfens archive root was not found" if root_dir.nil?

    bin_dir = "#{root_dir}/bin"
    lib_dir = "#{root_dir}/lib"
    bin.install "#{bin_dir}/hyfens"
    bin.install "#{bin_dir}/tool" => "tool"
    lib.install Dir["#{lib_dir}/*"] if Dir.exist?(lib_dir)
  end

  test do
    system bin / "hyfens", "--version"
  end
end
