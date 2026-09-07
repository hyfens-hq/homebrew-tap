class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.5/hyfens-0.1.5-macos-arm64.tar.gz"
      sha256 "c08fa71c1a405cab5908120c7a774ec00418fde2dec2f62843b2973677fae90a"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.5/hyfens-0.1.5-macos-x64.tar.gz"
      sha256 "a120360dac09a724422627eaaa718cec193216866680658efc6e31a1e89cdba1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.5/hyfens-0.1.5-linux-arm64.tar.gz"
      sha256 "d27462e447709d646740257ebbe01bc31fc4ecbf88b67238329dd06836f5544a"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.5/hyfens-0.1.5-linux-x64.tar.gz"
      sha256 "35257eb2fc96ad4c226ef29c306a5b7bf3f1c5e8a6cf860ab76584be7a45517f"
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
