class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.1/hyfens-0.1.1-macos-arm64.tar.gz"
      sha256 "3c98894c1b0aeab98cbe2d1a113bd5a020d699ff6df7fba806d742f341533abd"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.1/hyfens-0.1.1-macos-x64.tar.gz"
      sha256 "155b2c9bbe5262ff53ff5f61fa980fcbb898103934357b3d7c6f5f0045c9b66f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.1/hyfens-0.1.1-linux-arm64.tar.gz"
      sha256 "bf760163766cba168a808356430a5b748b74352e3df3af1c37b9a34a381185fe"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.1/hyfens-0.1.1-linux-x64.tar.gz"
      sha256 "10b7f8de9cac3c2bcea6994f2cce6653b19906740f9236cc219ca847df1e7e34"
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
