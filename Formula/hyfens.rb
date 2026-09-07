class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.10/hyfens-0.1.10-macos-arm64.tar.gz"
      sha256 "be8104c3a32082b34b40c160d2a20640dc9352c8592f97fa18bdb98b6fdc2c3d"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.10/hyfens-0.1.10-macos-x64.tar.gz"
      sha256 "2cbf5fb6256cd656e606c82f08c7f4689734924c0d4b7e18c8f0fac87656cee1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.10/hyfens-0.1.10-linux-arm64.tar.gz"
      sha256 "19c71dcd0543e71ac87a614e6be7ad4e8a0005c96bb8ff7226d03c8bcaec3845"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.10/hyfens-0.1.10-linux-x64.tar.gz"
      sha256 "cb0f97ee79968111267ccb0d7ff692989acb42988f3b522896da459322103cc2"
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
