class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.0/hyfens-0.1.0-macos-arm64.tar.gz"
      sha256 "319529ad526b27819214e905ca64b12029db632ae37bf71696c9ba13c4ba89e1"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.0/hyfens-0.1.0-macos-x64.tar.gz"
      sha256 "9fcbdf4494e337cd6e490ca42ffd56391ec8dad7047a264b239bd88ef6c17aa5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.0/hyfens-0.1.0-linux-arm64.tar.gz"
      sha256 "84db16a6667a0788e9c20613a37edb382a38d5fb0454509a9df43769939a6f01"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.0/hyfens-0.1.0-linux-x64.tar.gz"
      sha256 "5a45d340d743187082a74d5b5714e603e76762025abe26ff37f7f75864176250"
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
