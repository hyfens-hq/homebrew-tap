class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.7/hyfens-0.1.7-macos-arm64.tar.gz"
      sha256 "ab90a2f911ed0160eed971b13f4fd6d209905a76dcd83b639bc6b104a13cc7e0"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.7/hyfens-0.1.7-macos-x64.tar.gz"
      sha256 "97fb9ca3e3b8f0c3357e143786dd937e6e0de161250e93a689b4c5f0375847d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.7/hyfens-0.1.7-linux-arm64.tar.gz"
      sha256 "3777fba9dce324e5c09ebb1e79691d3f568b8c8ffa874b977a367cc73adbe83f"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.7/hyfens-0.1.7-linux-x64.tar.gz"
      sha256 "6911341a34c941786239e4cd4e683241b60d4f2cf8b251ef7b7046efb2e482c4"
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
