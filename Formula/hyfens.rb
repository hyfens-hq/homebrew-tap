class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.8/hyfens-0.1.8-macos-arm64.tar.gz"
      sha256 "20e667a13e81d6fa2e92c466f4ada8544031b59162ba76af4b607b456293e97c"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.8/hyfens-0.1.8-macos-x64.tar.gz"
      sha256 "7c7901e5f54555f848a71649ab4dc778b12c797d894bdbb2155a25e4d24012b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.8/hyfens-0.1.8-linux-arm64.tar.gz"
      sha256 "10cdc89f7b95b180ff19832d36fb65851298037c7abc15cb8891d6476551319e"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.8/hyfens-0.1.8-linux-x64.tar.gz"
      sha256 "20c9d631cf36ec9c58d7b80601ec2b0017bfb832703122f1674e92da4515133a"
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
    runtime_dir = "#{root_dir}/runtime"
    raise "Hyfens runtime bundle was not found" unless Dir.exist?(runtime_dir)

    bin.install "#{bin_dir}/hyfens"
    bin.install "#{bin_dir}/tool" => "tool"
    lib.install Dir["#{lib_dir}/*"] if Dir.exist?(lib_dir)
    prefix.install runtime_dir
  end

  test do
    system bin / "hyfens", "--version"
    assert_path_exists prefix/"runtime/hyfens_flutter_integration/lib/flutter_integration.dart"
    assert_path_exists prefix/"runtime/path_provider/lib/path_provider.dart"
    assert_path_exists prefix/"runtime/objective_c/hook/build.dart"
  end
end
