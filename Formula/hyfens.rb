class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.2/hyfens-0.1.2-macos-arm64.tar.gz"
      sha256 "4ec4c23a038fd9edc586ab6fd95b81d3dc4f8b842aa321de14bb7a71d6b2d7d2"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.2/hyfens-0.1.2-macos-x64.tar.gz"
      sha256 "945b130a9c6ccd3c224005ce07bb1fd8181a26818d6b70385098f2b851fb3113"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.2/hyfens-0.1.2-linux-arm64.tar.gz"
      sha256 "7f9c88dfdf82a179eb0b5fd60feb9f93c380159f656494b805e36ab53b5e220f"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.2/hyfens-0.1.2-linux-x64.tar.gz"
      sha256 "97a4dedd8bac08cf2364bff88f288e4446653c54e7f08bf710bf28440997b860"
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
